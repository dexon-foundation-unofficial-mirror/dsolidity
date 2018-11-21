#!/usr/bin/env sh

set -e

docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
version=$($(dirname "$0")/get_version.sh)
if [ "$TRAVIS_BRANCH" = "develop" ]
then
    docker tag dexonfoundation/dsolc:build dexonfoundation/dsolc:nightly;
    docker tag dexonfoundation/dsolc:build dexonfoundation/dsolc:nightly-"$version"-"$TRAVIS_COMMIT"
    docker push dexonfoundation/dsolc:nightly-"$version"-"$TRAVIS_COMMIT";
    docker push dexonfoundation/dsolc:nightly;
elif [ "$TRAVIS_TAG" = v"$version" ]
then
    docker tag dexonfoundation/dsolc:build dexonfoundation/dsolc:stable;
    docker tag dexonfoundation/dsolc:build dexonfoundation/dsolc:"$version";
    docker push dexonfoundation/dsolc:stable;
    docker push dexonfoundation/dsolc:"$version";
else
    echo "Not publishing docker image from branch $TRAVIS_BRANCH or tag $TRAVIS_TAG"
fi
