#!/usr/bin/env -S awk -f

BEGIN {
    FS=","
}
{
    for (i=1; i<=NF; i++) {
        fish[$i]++
    }
    
    for (days_after=1; days_after<=80; days_after++) {
        for (i=0; i<=8; i++)
            fish[i-1] = fish[i]
        fish[6]+=fish[-1]
        fish[8]=fish[-1]
    }

    for (i=0; i<=8; i++) fish_count+=fish[i]
    print fish_count
}
