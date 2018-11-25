FROM python:alpine
#RUN apk add --update curl jq py-pip && pip install --upgrade pip && pip install requests
RUN pip install requests
#COPY test.sh .
#RUN chmod +x test.sh
#ENTRYPOINT [ "sh", "-c", "./test.sh" ]

COPY test.py .
RUN chmod +x test.py
ENTRYPOINT python test.py