#!/bin/bash

XTEND_BUNDLE=xtendmed.zip

USERNAME=dsmithau

IMAGE=openkm

version=`cat VERSION`

echo "version: $version"


docker build -t $USERNAME/$IMAGE:latest . 


docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version

docker push $USERNAME/$IMAGE:latest
docker push $USERNAME/$IMAGE:$version
