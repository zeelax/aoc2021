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
        for (f=1; f<=fold[0]; f++) {
            split(fold[f], a, "=")
            b = (a[1]=="x")?1:2
            if (c[b] > a[2]) c[b] = a[2] - (c[b] - a[2])
        }
        q[c[1],c[2]] = "#"
        if (max["x"] < c[1]) max["x"] = c[1]
        if (max["y"] < c[2]) max["y"] = c[2]
    }

    for (j=0; j<=max["y"]; j++) {
        for (i=0; i<=max["x"]; i++) {
            printf("%s", (q[i,j]?q[i,j]:" "))
        }
        print ""
    }
}