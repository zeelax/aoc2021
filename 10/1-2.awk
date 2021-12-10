#!/usr/bin/env -S awk -f
function stack_is_empty(a) {return a[0] == 0}
function stack_top(a) {return a[a[0]]}
function stack_push(a, val) {a[++a[0]] = val}
function stack_pop(a,  i) {if(stack_is_empty(a)) {return NULL} else {i = a[0]--; x = a[i]; delete a[i]; return x}}

BEGIN {
    is_opening["("] = 1
    is_opening["["] = 1
    is_opening["{"] = 1
    is_opening["<"] = 1
    is_opening[")"] = 0
    is_opening["]"] = 0
    is_opening["}"] = 0
    is_opening[">"] = 0

    make_pair[")"] = "("
    make_pair["]"] = "["
    make_pair["}"] = "{"
    make_pair[">"] = "<"

    points[")"] = 3
    points["]"] = 57
    points["}"] = 1197
    points[">"] = 25137
    points["("] = 1
    points["["] = 2
    points["{"] = 3
    points["<"] = 4
}

{
    len = split($1, line, "")
    for (i in line) {
        if (is_opening[line[i]]) {
            stack_push(a, line[i])
        } else {
            if (make_pair[line[i]] == stack_top(a)) {
                stack_pop(a)
            } else {
                syntax_score += points[line[i]]
                break
            }
        }
        if (i == len) {
            k++
            while (!stack_is_empty(a)) {
                score_list[k] *= 5
                score_list[k] += points[stack_pop(a)]
            }
        }
    }
    while (!stack_is_empty(a)) stack_pop(a)
}
END {
    asort(score_list)
    print syntax_score
    print score_list[(k+1)/2]
}