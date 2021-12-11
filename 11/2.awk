#!/usr/bin/env -S awk -f
function stack_is_empty(a) {return a[0] == 0}
function stack_top(a) {return a[a[0]]}
function stack_push(a, val) {a[++a[0]] = val}
function stack_pop(a,  i) {if(stack_is_empty(a)) {return NULL} else {i = a[0]--; x = a[i]; delete a[i]; return x}}

BEGIN {FS=""}
{
    for (i=1; i<=NF; i++) g[i, NR] = $i
}
END {
    while (f != NF*NR) {
        step++
        for (j=1; j<=NR; j++)
            for (i=1; i<=NF; i++)
                if (++g[i,j] == 10) stack_push(a, i SUBSEP j)

        while (!stack_is_empty(a)) {
            split(stack_pop(a), e, SUBSEP)
            i = e[1]; j = e[2]
            if (i<1 || j<1 || i>NF || j>NR ) continue
            if (++g[i-1, j-1] == 10) stack_push(a, i-1 SUBSEP j-1)
            if (++g[i  , j-1] == 10) stack_push(a, i   SUBSEP j-1)
            if (++g[i+1, j-1] == 10) stack_push(a, i+1 SUBSEP j-1)
            if (++g[i-1, j  ] == 10) stack_push(a, i-1 SUBSEP j  )
            if (++g[i+1, j  ] == 10) stack_push(a, i+1 SUBSEP j  )
            if (++g[i-1, j+1] == 10) stack_push(a, i-1 SUBSEP j+1)
            if (++g[i  , j+1] == 10) stack_push(a, i   SUBSEP j+1)
            if (++g[i+1, j+1] == 10) stack_push(a, i+1 SUBSEP j+1)
        }

        f = 0
        for (j=1; j<=NR; j++)
            for (i=1; i<=NF; i++)
                if (g[i,j] > 9) {
                    g[i,j] = 0
                    f++
                }
    }
    print step
}