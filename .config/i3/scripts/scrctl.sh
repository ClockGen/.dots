#!/bin/bash
if [[ ! -f /tmp/xrandrbrightness  ]]; then
	echo 1.0 > /tmp/xrandrbrightness
fi
brightness=$(cat /tmp/xrandrbrightness)
monitor=$(xrandr | grep "primary" | awk '{print $1}')
increment='0.1'
if (( $(bc <<< "${brightness}>1") )); then
	symbol=
elif (( $(bc <<< "${brightness}>0.5") )); then
	symbol=
else
	symbol=
fi
case $1 in
	incr)
		if (( $(bc <<< "$brightness<2") )); then
			echo $(bc <<< "${brightness}+${increment}") > /tmp/xrandrbrightness
			xrandr --output $monitor --brightness $(cat /tmp/xrandrbrightness)
		fi
	;;
	decr)
		if (( $(bc <<< "$brightness>0.1")  )); then
			echo $(bc <<< "${brightness}-${increment}") > /tmp/xrandrbrightness
			xrandr --output $monitor --brightness $(cat /tmp/xrandrbrightness)
		fi
	;;
	*)
		echo "${symbol}  $(bc <<< "${brightness}*100" | awk -F '.' '{print $1}')%"
	;;
esac
