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
		if pamixer --get-mute >/dev/null ; then
			echo "Muted"
		else
			echo "$(pamixer --get-volume)%"
		fi
	;;
esac
