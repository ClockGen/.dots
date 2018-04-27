#!/bin/bash
time=$(date +"%T")
date=$(date +"%A %D")
case $1 in
	time)
		echo "  $time"
	;;
	date)
		echo "  $date"
	;;
esac
