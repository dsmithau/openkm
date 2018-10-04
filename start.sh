#!/bin/bash


/etc/init.d/mysql start

chmod u+x /etc/init.d/tomcat

/etc/init.d/tomcat start && sleep 60

mysql -h localhost -D okmdb -u openkm -p"Medicare01" -e "INSERT INTO OKM_EXTENSION (EXT_UUID, EXT_NAME) VALUES ('808e7a42-2e73-470c-ba23-e4c9d5c3a0f4', 'Live Edit')" && \
mysql -h localhost -D okmdb -u openkm -p"Medicare01" -e "INSERT INTO OKM_EXTENSION (EXT_UUID, EXT_NAME) VALUES ('58392af6-2131-413b-b188-1851aa7b651c', 'HTML Editor 4')" && \
mysql -h localhost -D okmdb  -u openkm -p"Medicare01" -e "INSERT INTO OKM_PROFILE_MSC_EXTENSION (PEX_ID, PEX_EXTENSION) VALUES (1, '808e7a42-2e73-470c-ba23-e4c9d5c3a0f4')" && \
mysql -h localhost -D okmdb -u openkm -p"Medicare01" -e "INSERT INTO OKM_PROFILE_MSC_EXTENSION (PEX_ID, PEX_EXTENSION) VALUES (1, '58392af6-2131-413b-b188-1851aa7b651c')" 

/etc/init.d/tomcat stop

sleep 60

/home/openkm/tomcat-8.5.24/bin/catalina.sh run