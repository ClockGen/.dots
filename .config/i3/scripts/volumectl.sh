#!/bin/bash
case "$1" in
	incr)
		pamixer -i 5
	;;
	decr)
		pamixer -d 5
	;;
	mute)
		pamixer -t
	;;
	*)
		volume=$(pamixer --get-volume)
		if pamixer --get-mute >/dev/null ; then
			echo ""
		else
			if [[ $volume -ge "35" ]]; then
				echo "  ${volume}%"
			else
				echo "  ${volume}%"
			fi
		fi
	;;
esac
