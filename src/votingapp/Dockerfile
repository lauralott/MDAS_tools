# BUILDER
FROM golang:stretch AS builder
RUN apt-get update && apt-get install -y git 

COPY deps.sh . 
RUN bash -c './deps.sh'

COPY . .
RUN go build -o /deploy/votingapp && cp -r ui /deploy

# RUNTIME
FROM ubuntu:18.04
WORKDIR /app
COPY --from=builder /deploy .
ENTRYPOINT [ "./votingapp" ]