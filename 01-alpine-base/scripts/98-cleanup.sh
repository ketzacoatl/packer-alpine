#!/bin/sh -eux
set -eux

source /etc/profile
###export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

apk info --installed salt-minion && apkRESULT="${?}" || apkRESULT="${?}"
	if [[ $apkRESULT == "0" ]]; then
		rc-service salt-minion stop
	fi



rm -rf /var/cache/apk/*
rm -rf /etc/ssh/ssh_host_*
sync