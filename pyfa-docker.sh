#!/usr/bin/sh

CURRENT_VERSION="v2.40.0"

echo "Starting pyfa-docker ${CURRENT_VERSION}..."

# Check if pyfa:$CURRENT_VERSION doesn't exist
if [[ "$(docker images -q pyfa:$CURRENT_VERSION 2> /dev/null)" == "" ]]; then
  echo "Image pyfa:$CURRENT_VERSION doesn't exist, building..."
  ./build.sh $CURRENT_VERSION
fi

docker run -t --rm --net=host \
       --user $(id -u):$(id -g)  \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $HOME/.Xauthority:$HOME/.Xauthority:rw \
       -v $HOME/.pyfa:$HOME/.pyfa \
       pyfa:$CURRENT_VERSION
