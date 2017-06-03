set -exu

apk upgrade -U --available

source /etc/os-release

apk add bash ca-certificates wget curl
