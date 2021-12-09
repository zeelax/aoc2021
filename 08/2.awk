#!/usr/bin/env -S awk -f

#
#  aaaa 
# f    b
# f    b
#  gggg 
# e    c
# e    c
#  dddd 
#

function diff(a, b, c) {
    for (ci in c) delete c[ci]
    for (ai in a) 
        for (bi in b)
            if (a[ai] == b[bi]) {c[ai] = a[ai]; a[ai] = "z"}
    asort(a)
    asort(c)
    for (ai in a) if (a[ai] == "z") delete a[ai]
}

BEGIN {}
{
    for (i in c) c[i]=0
    for (i=1; i<=10; i++)
        digits[length($i),++c[length($i)]] = $i
    #print digits[3,1]

    # compare 1 and 7, the difference is "a"
    #t["a"] = digits[3,1]
    split(digits[3,1], a, "")
    split(digits[2,1], b, "")
    diff(a, b)
    # for (i in a) 
    #     for (j in b)
    #         if (a[i] == b[j]) a[i] = "z"
    # asort(a)
    #for (i in a) printf "%d, %s\n", i, a[i]
    t["a"] = a[1]
    #print t["a"]

    # find 6, "subtract" 1, the result is "b"
    split(digits[2,1], b, "")
    for (i=1; i<=3; i++) {
        l = 0
        split(digits[6,i], a, "")
        diff(a, b, c)
        for (k in a) l++
        if (l == 5) { t["c"] = c[1]; i6 = i; break}
        
    }
    # print digits[2,1]
    # print digits[6,i6]

    #print t["b"]

    ## the other part of 1 is "c"
    split(digits[2,1], a, "")
    split(t["c"], b, "")
    diff(a, b)
    t["b"] = a[1]
    #print t["c"]

    # find 3, "subtract" 1
    split(digits[2,1], b, "")
    for (i=1; i<=3; i++) {
        l = 0
        split(digits[5,i], a, "")
        diff(a, b, c)
        for (k in a) l++
        if (l == 3) { i3 = i;}
        
        # for (k in a) printf "%d, %d, %s\n", i, k, a[k]
        # printf "\n"
    }
    #print i3

    # take 3, use it to find 9 (and "f")
    split(digits[5,i3], b, "")
    for (i=1; i<=3; i++) {
        l = 0
        split(digits[6,i], a, "")
        diff(a, b, c)
        for (k in a) l++
        if (l == 1) { t["f"] = a[1]; i9 = i}
        
        
        # for (k in a) printf "%d, %d, %s\n", i, k, a[k]
        # printf "\n"
    }
    #print t["f"]

    # "subtract" 3 from 8 to find "e"
    split(digits[7,1], a, "")
    split(digits[5,i3], b, "")
    diff(a, b)

    for (k in a) if (a[k] != t["f"]) t["e"] = a[k]
    
    # for (k in a) printf "%d, %d, %s\n", i, k, a[k]
    # printf "\n"
    #print t["e"]

    # find 0, subtract it from 8
    split(digits[7,1], a, "")
    for (i=1; i<=3; i++) {
        if (i == i6 || i == i9) { continue }
        split(digits[6,i], b, "")
        diff(a, b, c)
        t["g"] = a[1]

        
        # for (k in a) printf "%d, %d, %s\n", i, k, a[k]
        # printf "\n"
    }
    #print t["g"]
    
    split("abcdefg", a, "")
    for (j in a) {
        k = 0;
        for (i in t) {
            #printf "%s, %s    ", t[i], a[j]
            if (t[i] == a[j]) k++
            #print k
        }
        if (k == 0) t["d"] = a[j]
        #printf "%s, %d    ", a[j], k

    }
    #print t["d"]

    # for (k in t) printf "%s, %s\n", k, t[k]
    # printf "\n"

    p[0] = "abcdef"
    p[1] = "bc"
    p[2] = "abdeg"
    p[3] = "abcdg"
    p[4] = "bcfg"
    p[5] = "acdfg"
    p[6] = "acdefg"
    p[7] = "abc"
    p[8] = "abcdefg"
    p[9] = "abcdfg"

    for (i in t) ti[t[i]] = i
    for (i in p) pi[p[i]] = i

    r2 = ""
    for (i=12; i<=15; i++) {
        split($i, a, "")
        for (j in a) a[j] = ti[a[j]]
        asort(a)
        r = ""
        for (j in a) r = r a[j]
        r2 = r2 pi[r]
        #print pi[r]
    }
    print r2
    result+=r2
}
END {print result}