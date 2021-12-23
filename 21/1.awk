#!/usr/bin/env -S awk -f

function roll(dice, times,  r) {
    dice["rolls"] += times
    r = times/2*(dice["next"]*2+(times-1)*1)
    dice["next"] += times
    if (dice["next"] > 100) {
        r -= 200
        dice["next"] -= 100
    }
    return r
}

{
    position[$2] = $5
}

END {
    dice["next"] = 1
    print position[1], position[2]
    while (score[1] < 1000 && score[2] < 1000) {
        m++
        position[2 - m % 2] = ((position[2 - m % 2]+roll(dice, 3)-1) % 10) + 1
        score[2 - m % 2] += position[2 - m % 2]
    }
    # print position[1], position[2]
    # print score[1], score[2]
    # print dice["rolls"]
    print score[(score[1]>=1000)?2:1]*dice["rolls"]
}
