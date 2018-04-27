#!/bin/bash
i3-nagbar -t warning -m "Session end:" -b "Logout" 'i3-msg exit' -b "Shutdown" 'shutdown now'
