#!/bin/bash

crontab -l > crontab_new
echo "0 1 * * * schedule.sh" >> crontab_new
crontab crontab_new
rm crontab_new

