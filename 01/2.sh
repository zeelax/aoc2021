#!/bin/sh

awk 'NR==1 {w1 = $1; next} {w4=w3; w3=w2; w2=w1; w1=$1} NR>=4 {if (w1>w4) i++} END {print i}' input.txt
