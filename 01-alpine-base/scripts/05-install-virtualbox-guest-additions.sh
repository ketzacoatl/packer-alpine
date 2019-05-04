#!/bin/sh -eux
set -eux

retry() {
  local COUNT=1
  local RESULT=0
  while [[ "${COUNT}" -le 10 ]]; do
    [[ "${RESULT}" -ne 0 ]] && {
      [ "`which tput 2> /dev/null`" != "" ] && tput setaf 1
      echo -e "\\n${*} failed... retrying ${COUNT} of 10.\\n" >&2
      [ "`which tput 2> /dev/null`" != "" ] && tput sgr0
    }
    "${@}" && { RESULT=0 && break; } || RESULT="${?}"
    COUNT="$((COUNT + 1))"

    # Increase the delay with each iteration.
    DELAY="$((DELAY + 10))"
    sleep $DELAY
  done

  [[ "${COUNT}" -gt 10 ]] && {
    [ "`which tput 2> /dev/null`" != "" ] && tput setaf 1
    echo -e "\\nThe command failed 10 times.\\n" >&2
    [ "`which tput 2> /dev/null`" != "" ] && tput sgr0
  }

  return "${RESULT}"
}



if ! grep -q '^[^#].\+alpine/.\+/community' /etc/apk/repositories; then
    # Add community repository entry based on the "main" repo URL
    __REPO=$(grep '^[^#].\+alpine/.\+/main\>' /etc/apk/repositories)
    echo "${__REPO}" | sed -e 's/main/community/' >> /etc/apk/repositories
fi

# Ensure dmidecode is available.
retry apk add dmidecode

# Bail if we are not running atop VirtualBox.
if [[ `dmidecode -s system-product-name` != "VirtualBox" ]]; then
    exit 0
fi

	apk info --installed linux-vanilla && apkRESULT="${?}" || apkRESULT="${?}"
	if [[ $apkRESULT == "0" ]]; then
		retry apk add virtualbox-guest-additions virtualbox-guest-modules-vanilla
	# Autoload the virtualbox kernel modules.
	echo vboxguest >> /etc/modules
	echo vboxsf >> /etc/modules
	echo vboxvideo >> /etc/modules
	fi

	apk info --installed linux-virt && apkRESULT="${?}" || apkRESULT="${?}"
	if [[ $apkRESULT == "0" ]]; then
		retry apk add virtualbox-guest-additions virtualbox-guest-modules-virt
	# Autoload the virtualbox kernel modules.
	echo vboxguest >> /etc/modules
	echo vboxsf >> /etc/modules
	##echo vboxvideo >> /etc/modules
	fi

	rm -rf /root/VBoxVersion.txt
	rm -rf /root/VBoxGuestAdditions.iso
