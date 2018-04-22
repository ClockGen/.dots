#!/bin/bash

if ! cmus-remote -Q >/dev/null ; then
	exit 0
fi

case "$1" in 
	toggle)
		if [[ $(cmus-remote -Q | sed -n 's/^status //p') == "playing" ]]; then
			cmus-remote -C "player-pause"
		else
			cmus-remote -C "player-play"
		fi
	;;
	*)
		status="$(cmus-remote -Q | sed -n 's/^status //p')"
		artist="$(cmus-remote -Q | sed -n 's/^tag artist //p')"
		name="$(cmus-remote -Q | sed -n 's/^tag title //p')"
		if [[ $status != "stopped" ]]; then
			echo "$status | $artist - $name"
		else
			echo "$status"
		fi
	;;
esac


