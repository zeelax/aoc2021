#!/usr/bin/env -S awk -f

BEGIN{FS="[, ]"}
{
    if ($3) {
        fold[++i] = $3
        fold[0] = i
    } else {
        if ($2>=0) p[$1,$2] = "#"
    }
}
END {
    for (i in p) {
        split(i, c, SUBSEP)
        for (f=1; f<=1; f++) {
            split(fold[f], a, "=")
            b = (a[1]=="x")?1:2
            if (c[b] > a[2]) c[b] = a[2]*2 - c[b]
        }
        q[c[1],c[2]] = "#"
    }

    for (i in q) dots++
    print dots
}