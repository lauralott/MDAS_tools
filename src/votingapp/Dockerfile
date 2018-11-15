#
# >> BUILDER
FROM golang:alpine AS builder
RUN apk add --update git bash

COPY deps.sh .
RUN bash -c './deps.sh'

COPY . .
RUN go build -o /deploy/votingapp && cp -r ui /deploy
#RUN bash -c './pipeline.sh'

# >> RUNTIME
FROM golang:alpine
RUN apk add --update bash
WORKDIR /app
COPY --from=builder /deploy .
ENTRYPOINT [ "bash", "-c", "sleep 5 && ./votingapp" ]
# adds sleep to simulate delay in startup

