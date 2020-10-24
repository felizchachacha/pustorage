#!/usr/bin/awk -f

### uniq without sorting

NF !seen[$0]++

