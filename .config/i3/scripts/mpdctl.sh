#!/bin/bash

if ! $(mpc --host=${HOME}/.mpd/socket >/dev/null 2>/dev/null); then
	echo "mpd is not running"
	exit
fi
wmpc(){
	mpc --host=${HOME}/.mpd/socket "$@"
}
OUT="$(wmpc)"
case $1 in
	toggle)
		wmpc toggle
	;;
	next)
		wmpc next
	;;
	prev)
		wmpc prev
	;;
	seekf)
		wmpc seek +5%
	;;
	seekb)
		wmpc seek -5%
	;;
	stop)
		wmpc stop
	;;
	*)
		STAT=$(echo "$OUT" | awk '{print $1}' | sed -n '2s/^.\(.*\).$/\1/p')
		TRACK=$(echo "$OUT" | sed -n 1p)
		if [[ -n $STAT ]]; then
			echo "$STAT | $TRACK"
		else
			echo "Stopped"
		fi
	;;
esac
