#!/bin/bash

# Mount the repository and indexing areas
service nfs-common start
service rpcbind start


mount -t nfs ${NFS_SERVER_SERVER}:${NFS_SERVER_EXPORT_PATH} ${LOCAL_NFS_MOUNT_POINT}


# /etc/init.d/mysql start

chmod u+x /etc/init.d/tomcat


/home/openkm/tomcat-8.5.24/bin/catalina.sh run