#!/usr/bin/env -S awk -f

function abs(v) {v += 0; return v < 0 ? -v : v}

BEGIN{FS="[=.,]+"}
{
    x1 = $2; x2 = $3; y1 = $5; y2 = $6
}

END{
    for (start_x=0; start_x<=x2; start_x++) {
        for (start_y=-abs(y1); start_y<=abs(y2); start_y++) {
            m=0; r=0; i=0; j=0
            x = start_x; y = start_y
            while ((i<x1 || i>x2) || (j<y1 || j>y2)) {
                i+=x
                j+=y
                x+=(x>=0)?(x==0)?0:-1:1
                y--
                if (j>m) m = j
                if (i>x2 || j<y1) {m=0; r=1; break}
            }
            if (m>max) max = m
            if (!r) distinct_velocities++
        }
    }
    print max
    print distinct_velocities
}
