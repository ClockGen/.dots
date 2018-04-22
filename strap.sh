#!/bin/bash
#Very compact but functioning shitcode
[[ $(pwd) != "${HOME}/.dots" ]] && echo "not in .dots directory" && exit 1
BLACKLIST=( ".oh-my-zsh" ".vim/bundle" ".git" )
TARGDIR="${HOME}"
for FILE in ${BLACKLIST[*]}; do
	COMM="${COMM} -not -path \"./${FILE}/*\""
done
LIST="$(eval find $(dirname $0) -type f -not -name $(basename $0) -not -name \
\".gitignore\" -not -name \".gitmodules\" -not -name \"README.md\" ${COMM})"
docrap(){
	[[ -f $2 ]] && [[ -L $2 ]] && rm "$2" && echo "symlink"
	[[ -f $2  ]] && [[ ! -L $2 ]] && mv "$2" "$2.bak" && echo "notsymlink"
	mkdir -p "$(dirname $2)"
	ln -s "$1" "$2"
}
for FILE in $LIST; do
	localfile="$(echo $FILE | sed 's|^./||')"
	syml="${TARGDIR}/${localfile}"
	target="$(realpath $FILE)"
	docrap "$target" "$syml"
done
