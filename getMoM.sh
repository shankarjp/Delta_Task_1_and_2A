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

#Getting all the dates where the meetings are held
meeting_dates=($(grep -oP '[0-9]{4}-[0-9]{2}-[0-9]{2}' sysad-task-1-attendance.log | uniq))

#Validating the dates from the user interval
user_interval=()
START=$1
END=$2
start_date=$(date -d "$START" +%s)
end_date=$(date -d "$END" +%s)
k=0
while [[ "$start_date" -le "$end_date" ]]
do
        user_interval[$k]=$(date -d "@$start_date" +%F)
        let start_date+=86400
        ((k++))
done

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


#Here it is assumend that all the Mom's are created in the second year students directory

#Processing the output from the users directory

k=0
file_location=$(locate sysad-task-1-attendance.log)
while [ $k -lt ${#valid_dates[@]} ]
do
	a=($(grep -w ${valid_dates[$k]} sysad-task-1-attendance.log))
	i=${#a[@]}
	while [ $i -ge 4 ]
	do
        	i=$(($i-4))
        	j=0
        	while [ $j -lt ${#second_year[@]} ]
        	do
                	if [[ ${a[i]} = ${second_year[$j]} ]]
                	then
                        	cd /home/${second_year[$j]}
				file_content=$(cat "${valid_dates[$k]}_mom.txt")
				echo ${second_year[$j]} - ${valid_dates[$k]} - $file_content
                        	cd $file_location
	                       	break 2
			fi
                	((j++))
        	done
	done
	((k++))
done
