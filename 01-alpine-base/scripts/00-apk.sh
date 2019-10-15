set -exu

source /etc/profile
###export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

apk upgrade -U --available

source /etc/os-release

apk add bash ca-certificates wget curl
