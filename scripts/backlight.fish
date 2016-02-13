#!/usr/bin/fish

set direction $argv[1] # backlight up or down

set levels 1 2 5 10 20 30 50 70 90 120 150 180 210 255 # backlight levels 0 - off, 255 - max

set current (cat /sys/class/backlight/intel_backlight/brightness) #brightness control file

if [ $direction = "up" ]
	set direction ">"
else if [ $direction = "down" ]
	set direction "<"
	set levels $levels[-1..1]
else
	echo "Wrong parameter [up|down]"
	exit 1
end

for level in $levels
	if math "$level $direction $current" > /dev/null
		echo $level > /sys/class/backlight/intel_backlight/brightness
		echo $level
		break
	end
end	
