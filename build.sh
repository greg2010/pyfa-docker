#!/bin/sh

PYFA_VERSION=$1

docker build --build-arg UID=$(id -u) \
             --build-arg GID=$(id -g) \
             --build-arg UNAME=$(whoami) \
             --build-arg GNAME=$(getent group $(id -g) | cut -d: -f1) \
             --build-arg TZ=$(timedatectl show -p Timezone --value) \
             --build-arg PYFA_VERSION=$PYFA_VERSION \
             -t pyfa .

docker tag pyfa:latest pyfa:$PYFA_VERSION