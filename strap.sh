#!/bin/bash
#Very compact but functioning shitcode
[[ $(pwd) != "${HOME}/.dots" ]] && echo "not in .dots directory" && exit 1
BLACKLIST=( ".oh-my-zsh" ".zsh_custom" ".vim" ".git" )
FOLDERLIST=(".oh-my-zsh" ".zsh_custom" ".vim" )
TARGDIR="${HOME}"
for FILE in ${BLACKLIST[*]}; do
	COMM="${COMM} -not -path \"./${FILE}/*\""
done
LIST="$(eval find $(dirname $0) -type f -not -name $(basename $0) -not -name \
\".gitignore\" -not -name \".gitmodules\" -not -name \"README.md\" ${COMM})"
linkfile(){
	[[ -e $2 ]] && [[ -L $2 ]] && rm "$2"
	[[ -e $2  ]] && [[ ! -L $2 ]] && mv "$2" "$2.bak"
	mkdir -p "$(dirname $2)"
	ln -s "$1" "$2"
}
for FILE in $LIST; do
	localfile="$(echo $FILE | sed 's|^./||')"
	syml="${TARGDIR}/${localfile}"
	target="$(realpath $FILE)"
	linkfile "$target" "$syml"
done
for FOLDER in ${FOLDERLIST[*]}; do
	linkfile "$(realpath $FOLDER)" "${TARGDIR}/${FOLDER}"
done
