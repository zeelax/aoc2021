#!/usr/bin/env -S awk -f
function get_adjacent_a(p, a,  m,n,x,y,c,k) {
    split(p, c, SUBSEP)
    x = c[1]
    y = c[2]
    for (n=y-1; n<=y+1; n++) {
        for (m=x-1; m<=x+1; m++) {
            if ( (m==x-1 && n==y-1) ||
                 (m==x+1 && n==y+1) ||
                 (m==x-1 && n==y+1) || 
                 (m==x+1 && n==y-1) ||
                 (m==x && n==y) ) continue
            if (map[m,n]) a[k++] = m SUBSEP n
        }
    }
}

BEGIN {
    FS=""
}
{for (i=1; i<=NF; i++) map[i,NR] = $i}
END {
    for (n=0; n<=4; n++) {
        for (m=0; m<=4; m++) {
            if (m==0 && n==0) continue
            for (j=1; j<=FNR; j++) {
                for (i=1; i<=NF; i++) {
                    map[i+NF*m,j+FNR*n] = (map[i,j]+m+n>9)?map[i,j]+m+n-9:map[i,j]+m+n
                }
            }
        }
    }

    for (i in map) dist[i] = 2^PREC # sort of max_int
    dist[1,1] = 0
    queue[1,1] = 1
    while (length(queue)) {
        # pick the minimum distance vertex
        min = 2^PREC
        for (u in queue) {
            if (!spt[u] && map[u] && dist[u] < min) {
                min = dist[u]
                min_index = u
            }
        }

        # exit at destination
        if (min_index == NF*5 SUBSEP FNR*5) {
            print min
            break
        }

        # put the minimum distance vertex in the shortes path tree
        spt[min_index] = 1
        delete queue[min_index]
        
        # set distance for adjacent nodes and add them to the queue
        get_adjacent_a(min_index, a)
        for (j in a) {
            if (!spt[a[j]] && dist[a[j]] > dist[min_index] + map[a[j]]) {
                dist[a[j]] = dist[min_index] + map[a[j]]
                queue[a[j]] = 1
            }
        }
    }
}