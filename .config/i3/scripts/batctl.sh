#!/bin/bash
prefix="/sys/class/power_supply/BAT0"
capacity=$(cat ${prefix}/capacity)
if [[ $capacity -ge "90" ]]; then
	symbol=
elif [[ $capacity -ge "75" ]]; then
	symbol=
elif [[ $capacity -ge "50" ]]; then
	symbol=
elif [[ $capacity -ge "25" ]]; then
	symbol=
else
	symbol=
fi
if [[ $(cat ${prefix}/status) == "Charging" ]]; then
	echo "  $capacity%"
else
	echo "$symbol  $capacity%"
fi
