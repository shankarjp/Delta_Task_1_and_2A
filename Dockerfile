FROM ubuntu

#genarating the users
COPY ./genUser.sh /
RUN chmod +x ./genUser.sh
RUN ./genUser.sh

RUN apt-get update
RUN apt-get install acl
RUN apt-get install cron
RUN apt-get -y install python3.8
RUN apt-get -y install pip
RUN apt-get install -y mysql-server

#providing permission to all the users
COPY ./permitUser.sh /
RUN chmod +x ./permitUser.sh
RUN ./permitUser.sh

#copying files to their respective directory

COPY ./sysad-task-1-future.txt /home/Jay_Jay
COPY ./cron_schedule.sh /home/Jay_Jay
COPY ./schedule.sh /home/Jay_Jay

RUN chmod +x /home/Jay_Jay/cron_schedule.sh
RUN /home/Jay_Jay/cron_schedule.sh

COPY ./sysad-task-1-attendance.log /home/Jay_Jay
COPY ./attendance.sh /home/Jay_Jay

COPY ./genMoM.sh /home/Jay_Jay
COPY ./getMoM.sh /home/Jay_Jay

RUN pip install mysql-connector
COPY ./store_MoM.py /home/Jay_Jay


RUN service mysql start && \
    sleep 5s && \
    mysql -e "CREATE DATABASE store_MoMs" && \
    mysql -e "CREATE USER 'dhanush'@'localhost' IDENTIFIED BY 'password'"
