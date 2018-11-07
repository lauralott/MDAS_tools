# >> BUILDER
FROM golang:stretch AS builder
RUN apt-get update && apt-get install -y git golang

COPY deps.sh .
RUN bash -c './deps.sh'

COPY . .
RUN go build -o /deploy/votingapp && cp -r ui /deploy
#RUN bash -c './pipeline.sh'

# >> RUNTIME
FROM ubuntu:18.04
WORKDIR /app
COPY --from=builder /deploy .
ENTRYPOINT [ "./votingapp" ]

