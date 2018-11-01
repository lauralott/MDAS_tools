set -e #stops at exception
docker build -t votingapp-builder .
#docker run -it -v /${PWD}:/app -w /app votingapp-builder bash -c "./pipeline.sh"

docker build -t lauracortez/votingapp ./src/votingapp #se le indica la ruta aqui para no añadirla en scr/DockerFile

docker rm -f mvotingapp || true #kill previous container, (true) hides the error the first time
docker run --name mvotingapp -d -p 8085:8080 votingapp 

docker push lauracortez/votingapp

#kill all -> docker rm -f $(docker ps -qa)
