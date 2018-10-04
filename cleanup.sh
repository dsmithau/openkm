#!/bin/bash

CONTAINERS=`docker container ls -a | awk '{print $1}' | grep -v CONTAINER`

for CONT in $CONTAINERS
do
	docker container rm $CONT --force
done

IMAGES=`docker image ls -a | grep -v xtendmed | grep -v ubuntu | grep -v IMAGE | awk '{print $3}'`

for IMAGE in $IMAGES
do

	docker image rm $IMAGE --force
done

