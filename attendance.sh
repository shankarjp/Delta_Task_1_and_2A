#!/bin/bash

#creating arrays containing the usernames

sysAd=()
appDev=()
wedDev=()

for i in {1..30}
do
        if [ $i -lt 10 ]
        then
                sysAd[$i]="sysAd_0""$i"
                appDev[$i]="appDev_0""$i"
                webDev[$i]="webDev_0""$i"
        else
                sysAd[$i]="sysAd_""$i"
                appDev[$i]="appDev_""$i"
                webDev[$i]="webDev_""$i"
        fi
done

#Combining all those usernames into a single array
usernames=("${sysAd[@]}" "${appDev[@]}" "${webDev[@]}")


#Collecting the dates on which the meetings are held

meeting_dates=($(grep -oP '[0-9]{4}-[0-9]{2}-[0-9]{2}' sysad-task-1-attendance.log | uniq))

#Checking for the arguments passed by the user
if [ -z "$1" ] && [ -z "$2" ]
then
	START=2019-09-27
	END=$(date +%Y-%m-%d)
else
	START=$1
	END=$2
fi

#Collecting all the dates in between the user interval
user_interval=()
start_date=$(date -d "$START" +%s)
end_date=$(date -d "$END" +%s)
k=0
while [[ "$start_date" -le "$end_date" ]]
do
	user_interval[$k]=$(date -d "@$start_date" +%F)
	let start_date+=86400
	((k++))
done

#Checking whether dates in the user input interval, is there any meeting held

i=0
k=0
valid_dates=()
while [ $i -lt ${#meeting_dates[@]} ]
do
	j=0
	while [ $j -lt ${#user_interval[@]} ]
	do
		if [ ${user_interval[$j]} = ${meeting_dates[$i]} ]
		then
			valid_dates[$k]=${user_interval[$j]}
			((k++))
		fi
		((j++))
	done
	((i++))
done

#Final process
i=0
while [ $i -lt ${#valid_dates[@]} ]
do
	echo "Absentees on ${valid_dates[$i]}:"
	a=$(grep -w "${valid_dates[$i]}" sysad-task-1-attendance.log)
	j=0
	while [ $j -lt ${#usernames[@]} ]
	do
		if [[ "${a[@]}" == *"${usernames[$j]}"* ]]
		then
			((j++))
			continue
		else
			echo "	${usernames[$j]} is Absent"
		fi
		((j++))
	done
	((i++))
done
