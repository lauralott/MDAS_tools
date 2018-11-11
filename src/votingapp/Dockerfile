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
WORKDIR /app
COPY --from=builder /deploy .
ENTRYPOINT [ "./votingapp" ]

