#!/bin/sh

set -e -x

readonly script=${1}

[ -e ${script} ] || echo '#!/usr/bin/env bash' > ${script}

chmod +x ${script}
vim ${script}
