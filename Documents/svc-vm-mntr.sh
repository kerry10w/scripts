#!/bin/sh

ps auxw | grep docker | grep -v grep > /dev/null
#ps auxw | grep service-voicemail-monitor | grep -v grep > /dev/null

if [ $? != 0 ]
then
        #/sbin/service service-voicemail-monitor restart > /dev/null 2>&1
       systemctl start docker 
       echo "I should not run since service is already running"
fi

echo "passed docker start test"

#svc_pid=$(pidof -s /srv/service-voicemail/bin/python -m voicemail.asterisk_mailbox_daemon)

svc_pid=$(pidof -s /usr/bin/dockerd)

echo "Service PID: " $svc_pid

threadct=$(ps hH p $svc_pid | wc -l)

echo "Thread Count: " $threadct

if [ $threadct -lt 20 ]
then
        #/sbin/service service-voicemail-monitor restart > /dev/null 2>&1
       systemctl restart docker 
       echo "Docker has been restarted"
fi

echo "The End"
