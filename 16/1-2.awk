#!/usr/bin/env -S awk -f

function bin2dec(b,   i, d) {
    d=0
    for (i=1; i<=length(b); i++) {d=(d*2)+substr(b,i,1)}
    return d
}

function read_packet(message, pos,  i,r,j,version,k,value,v,l,subpacket_bit_count,subpacket_count,type_id) {
    i = pos

    # if all that is left is zeroes, exit
    if (!substr(message, pos, length(message)-pos)+0) {return}

    # read version
    version = bin2dec(substr(message, i, 3))
    i+=3
    # read type ID
    type_id = substr(message, i, 3)
    i+=3

    # check type ID
    if (type_id == types["value"]) {
        # got a value
        # keep reading packages until see a 0 prefix
        while (substr(message, i, 1) == "1") {
            value = value substr(message, i+1, 4)
            i+=5
        }
        # read value prefixed with 0
        value = value substr(message, i+1, 4)
        value = bin2dec(value)
        i+=5
    } else {
        # got an operator
        # read length type ID
        length_type_id = substr(message, i, 1)
        i++
        if (length_type_id == "1") {
            subpacket_count = bin2dec(substr(message, i, 11))
            i+=11
            for (j=1; j<=subpacket_count; j++) {
                split(read_packet(message, i), r, " ")
                i+=r[1]; version+=r[2]; v[++l] = r[3]
            }
        } else {
            subpacket_bit_count = bin2dec(substr(message, i, 15))
            i+=15
            k = i
            while (i-k <= subpacket_bit_count-1) {
                split(read_packet(message, i), r, " ")
                i+=r[1]; version+=r[2]; v[++l] = r[3]
            }
        }

        # OPERATE!
        if (type_id == types["sum"]) {
            value = 0
            for (l in v) value+=v[l]
        }
        if (type_id == types["product"]) {
            value = 1
            for (l in v) value*=v[l]
        }
        if (type_id == types["min"]) {
            value = 2^PREC
            for (l in v) if (v[l] < value) value = v[l]
        }
        if (type_id == types["max"]) {
            value = 0
            for (l in v) if (v[l] > value) value = v[l]   
        }
        if (type_id == types["gt"]) {
            value = v[1] > v[2]
        }
        if (type_id == types["lt"]) {
            value = v[1] < v[2]
        }        
        if (type_id == types["equal"]) {
            value = v[1] == v[2]
        }

    }

    return i - pos " " version " " value
}

BEGIN {
    FS=""

    h["0"] = "0000"; h["1"] = "0001"; h["2"] = "0010"; h["3"] = "0011"
    h["4"] = "0100"; h["5"] = "0101"; h["6"] = "0110"; h["7"] = "0111"
    h["8"] = "1000"; h["9"] = "1001"; h["A"] = "1010"; h["B"] = "1011"
    h["C"] = "1100"; h["D"] = "1101"; h["E"] = "1110"; h["F"] = "1111"

    types["sum"]     = "000"
    types["product"] = "001"
    types["min"]     = "010"
    types["max"]     = "011"
    types["value"]   = "100"
    types["gt"]      = "101"
    types["lt"]      = "110"
    types["equal"]   = "111"
}
{
    for (i=1; i<=NF; i++)
      message=message h[$i]
}
END {
    split(read_packet(message, 1), a, " ")
    print a[2]
    print a[3]
}