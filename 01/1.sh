#!/bin/sh

awk 'NR==1 {val = $1; next} {if ($1 > val) ++i; val=$1} END{print i}' input.txt
