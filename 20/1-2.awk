#!/usr/bin/env -S awk -f

function bin2dec(b,   i, d) {
    d=0
    for (i=1; i<=length(b); i++) {d=(d*2)+substr(b,i,1)}
    return d
}

function enhance_point(x, y, input_image, p,   b, i, j, r) {
    for (j=y-1; j<=y+1; j++) {
        for (i=x-1; i<=x+1; i++) {
            if (p) {
                b = b ((input_image[i,j] == ".")?"0":"1")
            } else {
                b = b ((input_image[i,j] == "#")?"1":"0")
            }
        }
    }

    r = enhancer[bin2dec(b)+1]
    return r
}

BEGIN {
    FS=""
    map["."] = 0
    map["#"] = 1
}
NR==1 {
    for (i=1; i<=NF; i++) enhancer[i] = $i; next
}
NR==2 {next}
{
    for (i=1; i<=NF; i++) {
        input_image[i,NR-2] = $i
    }
}

END {
    min_x = -1; min_y = -1
    max_x = NF; max_y = NR-2

    input_image[-1,-1] = "."

    for (s=1; s<=50; s++) {
        p = (input_image[min_x, min_y] == ".")?0:1
        min_x -= 2; min_y -= 2
        max_x += 2; max_y += 2
        #print p, min_x, min_y
        for (j=min_y; j<=max_y; j++) {
            for (i=min_x; i<=max_x; i++) {
                output_image[i,j] = enhance_point(i, j, input_image, p)
            }
        }
        delete input_image
        for (i in output_image) input_image[i] = output_image[i]

        if (s==2) {
            for (i in output_image) if (output_image[i] == "#") c1++
        }
    }

    for (i in output_image) if (output_image[i] == "#") c2++
    print c1
    print c2
}
