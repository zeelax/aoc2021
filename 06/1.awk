#!/usr/bin/env -S awk -f

BEGIN {
    FS=","
}
{
    printf("Initial state:  ")
    for (i=1; i<=NF; i++) {
        school[i] = $i
        printf("%d%s"), school[i], (i<fish_count)?",":"\n"
    }

    fish_count = NF
    for (days_after=1; days_after<=80; days_after++) {
        for (i=1; i<=fish_count; i++) {
            if (school[i] == 0) {
                school[i] = 6
                new_fish_round++
                school[fish_count+new_fish_round] = 8
            } else {
                school[i]--
            }
        }
        fish_count+=new_fish_round
        new_fish_round=0
        printf "After %03d day%s: ", days_after, (days_after>1)?"s":" "
        for (i=1; i<=fish_count; i++) {
            printf("%d%s"), school[i], (i<fish_count)?",":"\n"
        }
    }
}
END {print fish_count}
