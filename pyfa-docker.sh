#!/usr/bin/sh


# Get latest stable pyfa release
PYFA_UPDATE_URL="https://www.pyfa.io/update_check"
REMOTE_VERSION=$(curl -s $PYFA_UPDATE_URL | jq -c '[.[] | select(.prerelease == false)][0]["tag_name"]' | tr -d '"')
echo "Latest pyfa release: $REMOTE_VERSION"


CURRENT_VERSION=$REMOTE_VERSION
# In case pyfa.io is down etc fallback to the latest known version
if [ -z "${CURRENT_VERSION}" ]; then
  CURRENT_VERSION="v2.40.0"
fi

echo "Starting pyfa-docker ${CURRENT_VERSION}"

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
