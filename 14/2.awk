#!/usr/bin/env -S awk -f

BEGIN{FS=" -> "}

NR==1 {
    for (i=1; i<length($1); i++) {
        template[i] = substr($1,i,2)
    }
    last_element = substr($1,length($1),1)
    next
}
NR==2 {next}
{rules[$1]=$2}

END {
    for (i in template) p[template[i]]++
    for (i=1; i<=40; i++) {

        for (k in p) b[k] = p[k]
        for (j in p) {
            split(j, a, "")
            rule = rules[j]
            new_pairs[1] = a[1] rule
            new_pairs[2] = rule a[2]
            b[new_pairs[1]] += p[j]
            b[new_pairs[2]] += p[j]
            b[j] -= p[j]
            if (!b[j]) delete b[j]
        }
        for (k in p) delete p[k]
        for (k in b) p[k] = b[k]
        for (k in b) delete b[k]
    }

    for (i in p) {
        split(i, a, "")
        elements[a[1]] += p[i]
    }
    elements[last_element]++

    asort(elements)
    max = elements[1]
    min = elements[1]
    for (e in elements) {
        if (elements[e] > max) max = elements[e]
        if (elements[e] < min) min = elements[e]
    }
    print max - min
}
