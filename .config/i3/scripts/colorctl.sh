#!/bin/bash

midpoint=6500
tempincr=500
brightincr='0.1'
climits=( 1500 16000 )
blimits=( '0.1' '2' )

[[ ! -f /tmp/xrandrtemp ]] && echo $midpoint > /tmp/xrandrtemp
[[ ! -f /tmp/xrandrbrightness ]] && echo "1.0" > /tmp/xrandrbrightness

temperature=$(cat /tmp/xrandrtemp)
brightness=$(cat /tmp/xrandrbrightness)

getMonitor(){
	monitor=$(xrandr | grep "primary" | awk '{print $1}')
}

setScr(){
	#Formulas as well as coefficients were taken from this wonderful article:
	#http://www.tannerhelland.com/4435/convert-temperature-rgb-algorithm-code/

	#Calculating red
	if [[ $temperature -le $midpoint ]]; then
		red=1
	else #e( exponent * l(number) )
		red=$(bc -l <<< "scale=3;(329.698727446*e(-0.1332047592*l($temperature/100-60)))/255")
	fi
	
	#Calculating green
	if [[ $temperature -eq $midpoint ]]; then
		green=1
	elif [[ $temperature -lt $midpoint ]]; then
		green=$(bc -l <<< "scale=3;(99.4708025861*l($temperature/100)-161.1195681661)/255")
	else 
		green=$(bc -l <<< "scale=3;(288.1221695283*e(-0.0755148492*l($temperature/100-60)))/255")
	fi

	#Calculating blue
	if [[ $temperature -ge $midpoint ]]; then
		blue=1
	elif [[ $temperature -le 1900 ]]; then
		blue=0.01
	else
		blue=$(bc -l <<< "scale=3;(138.5177312231*l($temperature/100-10)-305.0447927307)/255")
	fi
	
	#Multiplying colors by brightness
	red=$(bc <<< "scale=3;${red}*${brightness}")
	green=$(bc <<< "scale=3;${green}*${brightness}")
	blue=$(bc <<< "scale=3;${blue}*${brightness}")

	getMonitor
	xrandr --output "$monitor" --gamma "$red:$green:$blue"
	echo "$red $green $blue $brightness $temperature"
}

case $1 in
	incr)
		if [[ $temperature -lt ${climits[1]} ]]; then
			temperature=$(( $temperature+$tempincr ))
			echo $temperature > /tmp/xrandrtemp
			setScr
		fi
	;;
	decr)
		if [[ $temperature -gt ${climits[0]} ]]; then
			temperature=$(( $temperature-$tempincr ))
			echo $temperature > /tmp/xrandrtemp
			setScr
		fi
	;;
	brincr)
		if (( $(bc <<< "$brightness<${blimits[1]}") )); then
			brightness=$(bc <<< "${brightness}+${brightincr}")
			echo "$brightness" > /tmp/xrandrbrightness
			setScr
		fi
	;;
	brdecr)
		if (( $(bc <<< "$brightness>${blimits[0]}") )); then
			brightness=$(bc <<< "${brightness}-${brightincr}")
			echo "$brightness" > /tmp/xrandrbrightness
			setScr
		fi
	;;
	gamma)
		if [[ $temperature -ge 11000 ]]; then
			tempsym=
		elif [[ $temperature -gt 9000 ]]; then
			tempsym=
		elif [[ $temperature -gt 6600 ]]; then
			tempsym=
		elif [[ $temperature -gt 6500 ]]; then
			tempsym=
		elif [[ $temperature -gt 2000 ]]; then
			tempsym=
		else
			tempsym=
		fi
		echo "$tempsym  ${temperature}K"
	;;
	bright)
		colsym=123
		if (( $(bc <<< "$brightness>1") )); then
			colsym=
		elif (( $(bc <<< "$brightness>0.5") )); then
			colsym=
		else
			colsym=
		fi
		echo "${colsym}  $(bc <<< "${brightness}*100" | awk -F '.' '{print $1}')%"
	;;
	reset)
		echo "$midpoint" > /tmp/xrandrtemp
		echo "1.0" > /tmp/xrandrbrightness
		getMonitor
		xrandr --output "$monitor" --gamma 1:1:1
	;;
esac
