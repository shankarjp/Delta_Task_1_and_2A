#!/bin/bash

#creating arrays containing the usernames

sysAd_2ndyear=()
appDev_2ndyear=()
wedDev_2ndyear=()

for i in {1..10}
do
	if [ $i -lt 10 ]
	then
		sysAd_2ndyear[$i]="sysAd_0""$i"
		appDev_2ndyear[$i]="appDev_0""$i"
		webDev_2ndyear[$i]="webDev_0""$i"
	else
		sysAd_2ndyear[$i]="sysAd_""$i"
		appDev_2ndyear[$i]="appDev_""$i"
		webDev_2ndyear[$i]="webDev_""$i"
	fi
done

second_year=("${sysAd_2ndyear[@]}" "${appDev_2ndyear[@]}" "${webDev_2ndyear[@]}")

a=($(grep -w $1 sysad-task-1-attendance.log))
i=${#a[@]}
while [ $i -ge 4 ]
do
	i=$(($i-4))
	j=0
	while [ $j -lt ${#second_year[@]} ]
	do
		if [[ ${a[i]} = ${second_year[$j]} ]]
		then
			last_joined_2nd_year=${second_year[$j]}
			echo $last_joined_2bd_year
			break 2
		fi
		((j++))
	done
done


cd /home/$last_joined_2nd_year
touch "$1_mom.txt"
echo Last join > "$1_mom.txt"
