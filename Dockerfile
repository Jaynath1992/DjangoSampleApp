FROM alpine:3.8
Maintainer Jaynath Kumar<Jaynath120.kumar@gmail.com>


LABEL Description="This is a base image, which provides the python django app"

RUN apk add --update --no-cache curl bash git openssh-client openssl zip wget
WORKDIR /opt/
COPY ./DjangoSampleApp /opt
RUN CD /opt/DjangoSampleApp
WORKDIR /opt/DjangoSampleApp

# Install python and then all dependecies from requirements.txt file
RUN apk add --update --no-cache python python-dev py-pip build-base libxslt-dev libxml2-dev \
  && pip install -r requirements.txt
  
RUN echo "http://mirror.yandex.ru/mirrors/alpine/v3.8/main" >> /etc/apk/repositories && \
  echo "http://mirror.yandex.ru/mirrors/alpine/v3.8/community" >> /etc/apk/repositories
 
 ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]
