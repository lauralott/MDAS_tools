set -e #stops at exception
image='votingapp'
builder_image='votingapp-builder'
m_image='mvotingapp'

docker build -t $builder_image .
docker run -v /${PWD}:/app -w /app $builder_image bash -c "./pipeline.sh"

docker build -t lauracortez/$image ./src/$image #se le indica la ruta aqui para no añadirla en scr/DockerFile

docker rm -f $m_image || true #kill previous container, (true) hides the error the first time
docker run --name $m_image -d -p 8085:8080 lauracortez/$image 

docker push lauracortez/$image

#kill all -> docker rm -f $(docker ps -qa)
