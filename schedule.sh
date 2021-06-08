#!/bin/bash


meeting_file="sysad-task-1-future.txt"
today_date=$(date +%Y-%m-%d)


while read line
do
	dates=$(echo $line | grep -oP '[0-9]{4}-[0-9]{2}-[0-9]{2}')
	timing=$(echo $line | grep -oP '[0-9]{2}:[0-9]{2}:[0-9]{2}')
	if [ $dates = "$today_date" ]
	then
		for files in /home/*
		do
			cd $files
			if [ -f "schedule.txt" ]
			then
				echo Meeting scheduled at "$dates" today, "$timing".Please join the meeting 5mins early. > schedule.txt
			else
				touch schedule.txt
				echo Meeting scheduled at "$dates" today, "$timing".Please join the meeting 5mins early. > schedule.txt
			fi
			cd ..
		done
	fi
done < $meeting_file
