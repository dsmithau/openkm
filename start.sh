#!/bin/bash

/etc/init.d/mysql start

chmod u+x /etc/init.d/tomcat

/etc/init.d/tomcat stop

sleep 60

/home/openkm/tomcat-8.5.24/bin/catalina.sh run