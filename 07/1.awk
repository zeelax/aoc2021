#!/usr/bin/env -S awk -f

function abs(v) {v += 0; return v < 0 ? -v : v}

BEGIN {RS=","}
NR==1 {min=$1; max=$1}
{crab[NR]=$1; if ($1>max) max=$1; if ($1<min) min=$1}
END {
    for (i=min; i<=max; i++) {
        f = 0; j = 1
        while (j<=FNR) {f+=abs(crab[j]-i); j++}
        (i==min)?fuel=f:f<fuel?fuel=f:0
    }
    print fuel
}
