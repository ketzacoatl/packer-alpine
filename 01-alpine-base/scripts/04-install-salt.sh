set -eux

if ! grep -q '^[^#].\+alpine/.\+/community' /etc/apk/repositories; then
    # Add community repository entry based on the "main" repo URL
    __REPO=$(grep '^[^#].\+alpine/.\+/main\>' /etc/apk/repositories)
    echo "${__REPO}" | sed -e 's/main/community/' >> /etc/apk/repositories
fi

apk --update add salt salt-minion
