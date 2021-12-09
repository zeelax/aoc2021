#!/usr/bin/env -S awk -f

NR == 1 {k = length($1)} 
{
    split($1, a, "")
    for (i in a) map[i,NR] = a[i]
}
END {
    for (j=1; j<=FNR; j++) {
        for (i=1; i<=k; i++) {
            u = (j-1 == 0)?9:map[i,j-1]
            d = (j+1 == FNR+1)?9:map[i,j+1]
            l = (i-1 == 0)?9:map[i-1,j]
            r = (i+1 == k+1)?9:map[i+1,j]
            if (map[i,j] < u &&
                map[i,j] < d &&
                map[i,j] < l &&
                map[i,j] < r) sum+=map[i,j]+1
        }
    }
    print sum
}