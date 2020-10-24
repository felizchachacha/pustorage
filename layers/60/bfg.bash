#!/usr/bin/env bash

set -xe

readonly DWNLD_D="/opt/bfg"
readonly DWNLD_LINK="https://repo1.maven.org/maven2/com/madgag/bfg/1.13.0/bfg-1.13.0.jar"

# java present
../../exe/apt-is-installed.bash default-jre-headless || aptitude -y install default-jre-headless

# fetch bfg.jar
[ -e "${DWNLD_D}" ] || mkdir ${DWNLD_D}"
readonly LOGTMPFILE=$(mktemp /tmp/$(basename "${0}").XXXXXX)
pushd "${DWNLD_D}"
	wget -c "${DWNLD_LINK}" 2>&1 | tee ${LOGTMPFILE}
	readonly DOWNLOADED_FNAME=$(tail -2 ${LOGTMPFILE} | awk -vFS='‘|’' '/saved/ {print $2}')
	rm ${LOGTMPFILE} &
	# install to /usr/local/bin
	echo -e "#!/usr/bin/env bash -xe\njava -jar "${DOWNLOADED_FNAME}" \$@" | tee /usr/local/bin/bfg
	# mark executable
	chmod +x /usr/local/bin/bfg
popd
