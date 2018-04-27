#!/bin/bash

case $1 in
	eth)
		ethstate=$(ip link | grep "enp" | awk -F ' ' '{print $9}')
		echo "  ${ethstate}"
	;;
	wifi)
	
		wlanstate=$(ip link | grep "wlp" | awk -F ' ' '{print $9}')
		if [[ $wlanstate == "UP" ]]; then
			wlan="$(iwgetid | awk -F '"' '{print $2}')"
		else
			wlan=$wlanstate
		fi
		echo "  ${wlan}"
	;;
esac
