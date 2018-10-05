#!/bin/bash

XTEND_BUNDLE=xtendmed.zip

USERNAME=dsmithau

IMAGE=openkm

currentversion=`cat VERSION`

MINOR=`echo ${currentversion} | awk -F "." '{print $2}'`

NEW_MINOR=$(( ${MINOR}+1 ))

NEWVERSION=0.${NEW_MINOR}

echo ${NEWVERSION} > VERSION

echo "Previous build version: ${currentversion}"
echo "Current build version: ${NEWVERSION}"

sleep 2

docker build -t $USERNAME/$IMAGE:latest . 


docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:${NEWVERSION}

# docker push $USERNAME/$IMAGE:latest
# docker push $USERNAME/$IMAGE:$version
