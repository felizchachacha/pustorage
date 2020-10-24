#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})

pushd ${MYDIR}/layers

	[ ${#} -eq 0 ] && set -- ??

	for layer in ${*}; do

		layer_basename=$(basename ${layer})
		
		pushd "${layer_basename}"
			
			[ -e "${layer_basename}" ] && cp -rv --backup "${layer_basename}"/* /

			ls -1 *shsource && for shsource in *shsource; do
				source "${shsource}"
			done

			ls -1 *sh && for script in *sh; do
				./"${script}"
			done

		popd

	done

popd
