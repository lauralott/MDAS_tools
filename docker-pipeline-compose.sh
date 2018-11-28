#!/bin/bash
set -e #stops at exception
image=${REGISTRY}/votingapp:${TAG}

docker-compose down
docker-compose up -d --build
docker-compose run --rm votingapp-test
docker-compose push votingapp

set +e
kubectl run database --image redis
kubectl expose deployment database --port 6379
kubectl run votingapp --image $image --env="REDIS=database:6379"
kubectl expose deployment votingapp --port 80 --type loadbalancer

set -e 
kubectl set image deployment/$app votingapp=$image
kubectl scale --replica=3 deployment/$app 

#REGISTRY=lauracortez TAG=1.0 ./docker-pipeline-compose.sh