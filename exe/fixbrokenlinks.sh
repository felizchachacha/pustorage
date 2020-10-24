for f in $(grep -aRl symlink); do linksource=$(cat "${f}" | tr -cd "[:print:]" | sed 's/\!<symlink>//g') && ln -svf "${linksource}" "${f}"; done

