#!/usr/bin/env -S awk -f
function stack_is_empty(a) {return a[0] == 0}
function stack_top(a) {return a[a[0]]}
function stack_push(a, val) {a[++a[0]] = val}
function stack_pop(a,  i) {if(stack_is_empty(a)) {return NULL} else {i = a[0]--; x = a[i]; delete a[i]; return x}}

function find_paths(u, d,   p, i, v) {
    visited[u]++
    stack_push(path, u)

    if (u == d) {
        t++
    } else {
        for (i=1; i<=g[u,0]; i++) {
            j = g[u,i]
            if (tolower(j) != j || !visited[j]) {
                find_paths(j, d)
            }
        }
    }
    stack_pop(path)
    visited[u] = 0
}

BEGIN {FS="-"}
{
    g[$1,++g[$1,0]] = $2
    g[$2,++g[$2,0]] = $1
}
END {
    find_paths("start", "end")
    print t
}
