FROM golang:alpine
RUN apk add --update curl jq bash python py-pip && pip install --upgrade pip && pip install requests

#COPY test.sh .
#RUN chmod +x test.sh
#ENTRYPOINT [ "bash", "-c", "./test.sh" ]

COPY test.py .
RUN chmod +x test.py
ENTRYPOINT python test.py