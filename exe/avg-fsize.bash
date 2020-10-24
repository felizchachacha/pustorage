#!/usr/bin/env bash

readonly DIRs=${*:-'.'}

echo "ordinary files only by MattBianco" # https://stackoverflow.com/questions/9195493/unix-find-average-file-size
time find ${DIRs} -type f -ls | awk '{s+=$7} END {printf "%.0f\n", s/NR}'

echo "all files by cnst" # https://stackoverflow.com/questions/9195493/unix-find-average-file-size/14393581#14393581
time find ${DIRs} -ls | awk '{sum += $7; n++;} END {print sum/n;}'

echo "all files by Stéphane Chazelas" # https://unix.stackexchange.com/questions/63370/compute-average-file-size
time find ${DIRs} -type f -printf '%s\n' | awk '{s+=$0} END {printf "Count: %u\nAverage size: %.2f\n", NR, s/NR}'

