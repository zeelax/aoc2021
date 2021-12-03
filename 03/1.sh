#!/bin/sh

awk 'NR=1 {len = length($1)} {for (i = 1; i <= len; ++i) bits[i] = bits[i]+substr($1,i,1)} END {for (i=1; i<=len; ++i) {if (bits[i] > FNR/2) {gamma = gamma 1; epsilon = epsilon 0} else {gamma = gamma 0; epsilon = epsilon 1}} printf "ibase=2;%s*%s\n", gamma, epsilon}' input.txt | bc
