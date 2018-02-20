#!/bin/bash 
#===============================================================================
#          FILE: mysql_run.sh
#         USAGE: ./mysql_run.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
# 	LICENSE: AGPLv3+
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR:Roie Beck, <Roie.Beck@kaltura.com>
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 02/13/18 10:48 EST
#      REVISION:  ---
#===============================================================================

# set SElinux enforcement to permissive
setenforce permissive

##
## config file must exist in all components
##

if [ -w /root/install/config.ans ] && [ ! -e /root/install/installed.ans ]; then
	dos2unix /root/install/config.ans
	. /root/install/config.ans #read the config.ans file into variables
else
	echo answer file must exist and be writeable
	exit 1
fi

##
##  installation is done if exist
##
if ! [ -e /root/install/installed.ans ]; then
	echo 'running /opt/kaltura/bin/kaltura-nfs-client-config.sh $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP'
	/opt/kaltura/bin/kaltura-nfs-client-config.sh $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP
	echo done configuring nfs
	/opt/kaltura/bin/kaltura-dwh-config.sh /root/install/config.ans
	touch /root/install/installed.ans
	echo "installed" >> /root/install/installed.ans
fi

