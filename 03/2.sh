#!/bin/bash

calculate_gamma_epsilon() {
    awk "/^$1/" input.txt | awk 'NR=1 {len = length($1)} {for (i = 1; i <= len; ++i) bits[i] = bits[i]+substr($1,i,1)} END {for (i=1; i<=len; ++i) {if (bits[i] >= FNR/2) {gamma = gamma 1; epsilon = epsilon 0} else {gamma = gamma 0; epsilon = epsilon 1}} print gamma, epsilon, FNR}'
}

#calculate co2 scrubber rating
position=1
regex=''
while true; do
    output=($(gamma_epsilon "$regex"))
    gamma=${output[0]}
    epsilon=${output[1]}
    numbers_left=${output[2]}
    regex="${regex}${gamma:$position-1:1}"
    ((position++))
    if [ $numbers_left == "1" ];
    then
        break;
    fi
done
oxygen=$gamma

#calculate co2 scrubber rating
position=1
regex=''
while true; do
    output=($(gamma_epsilon "$regex"))
    gamma=${output[0]}
    epsilon=${output[1]}
    numbers_left=${output[2]}
    regex="${regex}${epsilon:$position-1:1}"
    ((position++))
    if [ $numbers_left == "1" ];
    then
    	break;
    fi
done
co2=$gamma

echo -e "ibase=2;$oxygen*$co2\n" | bc