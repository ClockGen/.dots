#!/bin/bash
if [[ ! -e /proc/acpi/bbswitch ]]; then
	exit 0
fi
state=$(cat /proc/acpi/bbswitch | awk -F ' ' '{print $2}')
if [[ $state == "ON" ]]; then
	echo "  "
else
	echo "  "
fi

