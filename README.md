# docker-jenkins

## Introduction

This image aims to provide a custom docker image with jenkins, a set of base plugins and a docker client.

## Usage

```
docker run -d \
           -p 8080:8080 \
           -p 50000:50000 \
           -v /your/home:/var/jenkins_home \
           -v /var/run/docker.sock:/var/run/docker.sock \
           amontaigu/jenkins
```

## Documentations and references

* [Docker image source](https://github.com/docker-library/docker)
* [Docker image](https://hub.docker.com/_/docker/)
* [Jenkins docker image source](https://github.com/jenkinsci/docker)
* [Jenkins docker image](https://hub.docker.com/_/jenkins/)
