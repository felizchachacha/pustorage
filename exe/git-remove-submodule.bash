#!/usr/bin/env bash

#from https://gist.github.com/fabifrank/cdc7e67fd194333760b060835ac0172f
#by  @fabifrank
#https://gist.github.com/fabifrank

if [ -z "$1" ]; then
	echo "Missing submodule"
	exit 1
fi

sn=$1

# verify that the folder is not deleted while there are unsaved changes
if [ -d $sn/.git ]; then
	cd $sn
	if [ "$?" -eq "0" ]; then
		status=$(git status --porcelain)
		if [ -n "${status}" ]; then
			printf '\n\n!!! CAUTION !!!\n\n';
			printf 'Submodule contains untracked/unstaged/unpushed changes:\n'
			echo ${status}
			printf "\n\n"
			read -n 1 -p 'Are you sure you want to continue? [Enter]' con;
			echo '';
			if [ "${con}" != "" ]; then
				echo "abort"
				exit 1
			fi
		fi

		read -n 1 -p 'Shall the repo be pushed to origin before deletion? [Enter]' con
		if [ "${con}" = "" ]; then
			git push
		fi

		echo ''
		cd -
	fi
fi


function remove() {
	line=$(cat ${1} | grep -n "\[submodule \"${sn}\"\]")
	line="${line:0:1}"
	end="$(($line+2))"
	sed -i.bak "$line,${end}d" ${1}
}


remove .gitmodules
remove ".git/config"

printf "\n\nDiff .gitmodules"
diff .gitmodules .gitmodules.bak

printf "\n\nDiff .git/config\n"
diff .git/config .git/config.bak

printf "\n\n"

# verify removed lines are ok
read -n 1 -p "Diffs of .gitmodules and .git/config ok? [Enter]" con;
if [ "$con" != "" ]; then
	echo "Aborted.."
	mv .gitmodules.bak .gitmodules
	mv .git/config.bak .git/config
	echo "Changes reverted"
	exit 1
fi


git add .gitmodules
git rm -rf .git/modules/${1}
git commit -m "remove submodule ${1}"
rm -rf ${1}
echo "Done!"
