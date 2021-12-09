#!/usr/bin/env -S awk -f

function f(x,y, b,s,arr,c) {
    s = 0

    arr[(y-1 == 0)?9:1] = x SUBSEP y-1
    arr[(y+1 == FNR+1)?9:2] = x SUBSEP y+1
    arr[(x-1 == 0)?9:3] = x-1 SUBSEP y
    arr[(x+1 == k+1)?9:4] = x+1 SUBSEP y

    for (b in arr) {
        if (b <= 4 && e[arr[b]] != 1 && map[arr[b]] > map[x,y]) {
            e[arr[b]] = 1
            split(arr[b], c, SUBSEP)
            s += (map[arr[b]]<9)?1:0
            s += f(c[1], c[2])
        }

    }
    return s
}

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
                map[i,j] < r) {
                baisin[++m] = f(i,j)+1
            }
        }
    }
    asort(baisin)
    res = 1
    for (i=m; i>m-3; i--) {
        res *= baisin[i]
    }
    print res
}