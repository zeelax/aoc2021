#!/usr/bin/env -S awk -f

function add_numbers(a, b,  r) {
    r = "[" a "," b "]"
    return r
}

function explode_number(a,  c, d, e, f, i, j, k, l, n, m, r) {
    # find the first pair nested in 4 pairs
    while (substr(a, i, 1) && c<5) {
        i++
        c+=p[substr(a, i, 1)]
        # store the start position of the previous pair
        if (c == 4 && p[substr(a, i, 1)]) k = i
    }
    if (!c) {return}
    l = i
    c = 0
    while (substr(a, l, 1) && c>=-1) {
        l++
        c+=p[substr(a, l, 1)]
        if (c == -1 && p[substr(a, l, 1)] && !j) j = l
        #print l, c, j, substr(a, l, 1)
    }
    #print j, l
    # found coordinates [ [] ]
    #                   ^ ^^ ^
    #                   k ij l

    # get inner (n[]) numbers 
    split(substr(a, i+1, j-i-1), n, ",")
    # get numbers on the left and right (m[])
    x = i
    c = 0
    d = 0
    while (x>0 && !d) {
        x--
        if (!p[substr(a, x, 1)] && substr(a, x, 1) != "," && !c) c = x
        if ((p[substr(a, x, 1)] || substr(a, x, 1) == ",") && c) d = x
    }

    m[1] = substr(a, d+1, c-d)
    x = j
    e = 0
    f = 0
    while (x<=length(a) && !f) {
        x++
        if (!p[substr(a, x, 1)] && substr(a, x, 1) != "," && !e) e = x
        if ((p[substr(a, x, 1)] || substr(a, x, 1) == ",") && e) f = x
    }
    m[2] = substr(a, e, f-e) 
    r = substr(a, 1, d) ((m[1])?m[1]+n[1]:"") substr(a, c+1, i-c-1) "0" substr(a, j+1, e-j-1) ((m[2])?m[2]+n[2]:"") substr(a, f, (f==0)?0:length(a)-f+1)

    return r
}

function split_number(a,  i, j, x, n, m, r) {
    while(i<=length(a) && !j) {
        x++
        if (!p[substr(a, x, 1)] && substr(a, x, 1) != "," && !i) i = x
        if ((p[substr(a, x, 1)] || substr(a, x, 1) == ",") && i) j = x
        if (j && j-i <=1) {i = 0; j = 0}
    }
    if (!j) return
    n[0] = substr(a, i, j-i)
    split(n[0]/2, m, ".")
    n[1] = m[1]
    n[2] = n[0] - n[1]

    r = substr(a, 1, i-1) "[" n[1] "," n[2] "]" substr(a, j)

    return r
}

function reduce_once(a,  e, s, r) {
    e = explode_number(a)
    if (e) {
        r = e
    } else {
        s = split_number(a)
        if (s) {
            r = s
        } else {
            r = a
        }
    }

    return r
}

function reduce_number(a,  h) {
    while (a != h) {
        h = a
        a = reduce_once(a)
    }

    return a
}

function calculate_magnitude(a,  b, i, j, k, l, m, n, c, x, r) {
    while (substr(a, x, 1)) {
        x++
        c+=p[substr(a, x, 1)]
        if (c == 1 && !i) i = x
        if (c == 0 && !j) j = x 
        if (c == 2 && !k) k = x
        if (c == 1 && !l && k) l = x
        if (c == 2 && !m && l) m = x
        if (c == 1 && !n && m) n = x
    }

    # now we know [ [ ],[ ] ]
    # or          i k l m n j   # both are lists        [[1,2],[3,4]]
    # or          i k l     j   # only left is a list   [[1,2],3]
    # or          i     k l j   # only right is a list  [1,[2,3]]
    # or          i         j   # just one list         [1,2]
    # or                    j   # plain number          1

    if (!k) {
        if (!i) {
            return a
        } else {
            split(substr(a, i+1, j-i-1), b, ",")
            r = 3*b[1] + 2*b[2]
            return r
        }
    } else {
        if (!m) {
            if (k-i > 1) {
                b[1] = substr(a, i+1, k-i-2); b[2] = substr(a, k, j-k)
            } else {
            b[1] = substr(a, i+1, l-i); b[2] = substr(a, l+2, j-l-2)
            }
        } else {
            b[1] = substr(a, i+1, l-i); b[2] = substr(a, m, j-m)
        }
    }

    x = "[" calculate_magnitude(b[1]) "," calculate_magnitude(b[2]) "]"
    r = calculate_magnitude(x)
    return r
}

BEGIN {
    p["["] = 1
    p["]"] = -1
}
{
    numbers[++i] = $1
}
END {
    for (i in numbers) {
        if (i == 1) {
            sum = numbers[i]
        } else {
            sum = reduce_number(add_numbers(sum, numbers[i]))
        }
        for (j in numbers) {
            if (i!=j) {
                magnitude = calculate_magnitude(reduce_number(add_numbers(numbers[i], numbers[j])))
                if (magnitude > max_magnitude) max_magnitude = magnitude
            }
        }
    }
    magnitude = calculate_magnitude(sum)
    print magnitude
    print max_magnitude
}