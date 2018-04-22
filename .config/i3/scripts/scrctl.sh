#!/bin/bash
BPATH="/sys/class/backlight/intel_backlight/"
max=$(cat ${BPATH}max_brightness)
current=$(cat ${BPATH}brightness)
incr=$(( $max/100*5  ))
case $1 in
	up)
		echo "$(( $current+$incr ))" > "${BPATH}brightness"
	;;
	down)
		echo "$(( $current-$incr ))" > "${BPATH}brightness"
	;;
	*)
		echo "$(bc <<< "scale=2; $current/$max*100" | awk -F '.' '{print $1}')%"
	;;
esac
