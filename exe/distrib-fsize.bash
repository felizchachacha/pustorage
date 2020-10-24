#!/usr/bin/env bash

# https://superuser.com/questions/565443/generate-distribution-of-file-sizes-from-the-command-prompt

set -e

readonly DIRs=${*:-'.'}

echo "by garyjohn:"
time find ${DIRs} -type f -print0 | xargs -0 ls -l | awk '{size[int(log($5)/log(2))]++}END{for (i in size) printf("%10d %3d\n", 2^i, size[i])}' | sort -n

echo "by dzsuz87:"
time find ${DIRs} -type f -print0                                                   \
 | xargs -0 ls -l                                                        \
 | awk '{ n=int(log($5)/log(2));                                         \
          if (n<10) n=10;                                                \
          size[n]++ }                                                    \
      END { for (i in size) printf("%d %d\n", 2^i, size[i]) }'           \
 | sort -n                                                               \
 | awk 'function human(x) { x[1]/=1024;                                  \
                            if (x[1]>=1024) { x[2]++;                    \
                                              human(x) } }               \
        { a[1]=$1;                                                       \
          a[2]=0;                                                        \
          human(a);                                                      \
          printf("%3d%s: %6d\n", a[1],substr("kMGTEPYZ",a[2]+1,1),$2) }' 

echo "by terdon:"
time find ${DIRs} -type f -exec ls -lh {} \; |
 gawk '{match($5,/([0-9.]+)([A-Z]+)/,k); if(!k[2]){print "1K"} \
        else{printf "%.0f%s\n",k[1],k[2]}}' |
sort | uniq -c | sort -hk 2 

