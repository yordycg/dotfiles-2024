#!/usr/bin/bash
awk -F '/' '{if(NF > 4){print ""$(NF-1)"/"$(NF)}else{print}}' </dev/stdin
