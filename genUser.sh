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

#adding all the users
for j in {1..30}
do
	useradd -d/home/${sysAd[$j]} -m ${sysAd[$j]}
	passwd -d ${sysAd[$j]} > /dev/null
	useradd -d/home/${appDev[$j]} -m ${appDev[$j]}
	passwd -d ${appDev[$j]} > /dev/null
	useradd -d/home/${webDev[$j]} -m ${webDev[$j]}
	passwd -d ${webDev[$j]} > /dev/null
done

#adding the AlphaQ head user
useradd -d/home/Jay_Jay -m Jay_Jay
passwd -d Jay_Jay > /dev/null

echo
echo All the users for each domains has been added successfully
echo 'No password is set.So please add your password once you logged in'
echo Thank you
echo 
