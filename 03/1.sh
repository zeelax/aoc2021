#!/bin/sh

awk '/forward/ {h=h+$2} /down/ {d=d+$2} /up/ {d=d-$2} END {print h*d}' input.txt
