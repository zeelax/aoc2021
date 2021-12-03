#!/bin/sh

awk '/forward/ {h=h+$2; d=d+a*$2} /down/ {a=a+$2} /up/ {a=a-$2} END {print h*d}' input.txt
