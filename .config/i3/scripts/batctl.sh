#!/bin/bash
prefix="/sys/class/power_supply/BAT0"
if [[ $(cat ${prefix}/status) == "Charging" ]]; then
	echo "$(cat ${prefix}/capacity)%, CHR"
else
	echo "$(cat ${prefix}/capacity)%"
fi
