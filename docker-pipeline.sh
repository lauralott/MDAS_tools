#!/bin/bash
set -e #stops at exception
image='votingapp'
#registry=$(REGISTRY:-'lauracortez')
network='votingapp-network'
#builder_image='votingapp-builder' #no longer needed since src/Dockerfile is multistagging

#docker build -t $builder_image . #se pasa a src/dockerfile
#docker run -v /${PWD}:/app -w //app $builder_image bash -c "./pipeline.sh" #implements volume
#docker run $builder_image bash -c "./pipeline.sh"

docker network create $network || true #creates a network where images can be attached to

# >> BUILD
docker build -t lauracortez/$image ./src/votingapp #se le indica la ruta aqui para no añadirla en scr/DockerFile

# >> INTEGRATION TESTS
docker rm -f $image || true #kill previous container, (true) hides the error the first time
docker run --name $image -d --network $network lauracortez/$image #port mapping not needed

docker build -t votingapp-test ./test
docker run --rm --network $network -e VOTING_URL="http://$image:8080/vote" votingapp-test

# >> DELIVERY
docker push lauracortez/$image

#kill all -> docker rm -f $(docker ps -qa)
#clean images -> docker system prune -f