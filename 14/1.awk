#!/usr/bin/env -S awk -f

BEGIN{FS=" -> "}

NR==1 {template=$1; next}
NR==2 {next}
{rules[$1]=$2}

END {
    t = template
    for (i=1; i<=10; i++) {
        l = length(t)
        #print i, l
        split(t, a, "")
        for (j=1; j<l; j++) {
            insertion = rules[a[j]a[j+1]]
            #print insertion, ":", a[j], a[j+1]
            k = (j==1)?a[j]:""
            r = r k insertion a[j+1]
        }
        t = r
        r = ""
    }
    #print t

    split(t, a, "")
    for (i in a) b[a[i]]++
    asort(b)
    #for (i in b) print i, b[i]
    max_i = 1
    min_1 = 1
    max = b[1]
    min = b[1]
    for (i in b) {
        if (b[i] > max) {max = b[i]; max_i = i}
        if (b[i] < min) {min = b[i]; min_i = i}
    }
    print max - min
}
