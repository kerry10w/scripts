#!/bin/sh

ps auxw | grep docker | grep -v grep > /dev/null

if [ $? != 0 ]
then
        #/sbin/service docker restart > /dev/null 2>&1
       systemctl start docker 
       echo "I should not run"
fi

echo "passed docker being started"

#svc_pid=$(pidof -s /srv/service-voicemail/bin/python -m voicemail.asterisk_mailbox_daemon)

svc_pid=$(pidof -s /usr/bin/dockerd)

echo "Service PID: " $svc_pid

threadct=$(ps hH p $svc_pid | wc -l)

echo "Thread Count: " $threadct

if [ $threadct -lt 20 ]
then
        #/sbin/service docker restart > /dev/null 2>&1
       systemctl restart docker 
       echo "Docker has been restarted"
fi

echo "The End"
