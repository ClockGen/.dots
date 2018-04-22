#!/bin/bash
layt=$(setxkbmap -print -verbose 10 | sed -n 's/^layout:     //p')
case $1 in
	switch)
		if [[ $layt == "us" ]]; then
			setxkbmap "ru"
		else
			setxkbmap "us"
		fi
	;;	
	*)
		echo $layt	
	;;
esac
