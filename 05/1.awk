#!/usr/bin/env -S awk -f 

# Run with -v diagonals=1 to count diagonals as well

function abs(v) {v += 0; return v < 0 ? -v : v}

function plot(diagram, x1, y1, x2, y2) {
    if (x1 > x2) {x_inc = -1} else x_inc = 1
    if (y1 > y2) {y_inc = -1} else y_inc = 1

    if (x1 == x2) x_inc = 0
    if (y1 == y2) y_inc = 0

    x = x1; y = y1
    while (x != x2 + x_inc || y != y2 + y_inc) {
        diagram[x,y]++
        if (diagram[x,y] == 2) { overlap_point_count++ }
        x += x_inc
        y += y_inc
    } 
}
{
    split($1, line_start, ","); split($3, line_end, ",")
    x1=line_start[1]; y1=line_start[2]; x2=line_end[1]; y2=line_end[2]
    if (diagonals == 1 ) {
        plot(diagram, x1, y1, x2, y2)
    } else {
        if (abs(x2-x1) != abs(y2-y1)) plot(diagram, x1, y1, x2, y2)
    }

}
END {
    print overlap_point_count
}
