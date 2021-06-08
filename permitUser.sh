#!/bin/bash

#creating primary groups
groupadd 2nd_year
groupadd 3rd_year
groupadd 4th_year
groupadd sysAd
groupadd webDev
groupadd appDev

sysAd=()
appDev=()
wedDev=()

#creating array's of username
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

#adding user to their respective primary and secondary group
for j in {1..30}
do
	if [ $j -lt 11 ]
	then
		usermod -g2nd_year -GsysAd ${sysAd[$j]}
		usermod -g2nd_year -GappDev ${appDev[$j]}
		usermod -g2nd_year -GwebDev ${webDev[$j]}
	elif [ $j -gt 10 ] && [ $j -lt 21 ]
	then
                usermod -g3rd_year -GsysAd ${sysAd[$j]}
                usermod -g3rd_year -GappDev ${appDev[$j]}
                usermod -g3rd_year -GwebDev ${webDev[$j]}
        elif [ $j -gt 20 ] && [ $j -lt 31 ]
        then
                usermod -g4th_year -GsysAd ${sysAd[$j]}
                usermod -g4th_year -GappDev ${appDev[$j]}
                usermod -g4th_year -GwebDev ${webDev[$j]}
	fi
done

#changing the permission of Jay_Jay directory
chmod 770 /home/Jay_Jay

#providing permission according to the year
for file in /home/*
do
        if [ ${file: -2} -gt 10 ] && [ ${file: -2} -lt 21 ]
        then
                setfacl -R -m g:4th_year:rwx $file
		setfacl -R -m g:Jay_Jay:rwx $file
		setfacl -R -m o::--- $file
        elif [ ${file: -2} -gt 20 ] && [ ${file: -2} -lt 31 ]
        then
                setfacl -R -m g:Jay_Jay:rwx $file
		setfacl -R -m o::--- $file
        fi
done
