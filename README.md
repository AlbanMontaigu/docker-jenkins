# docker-jenkins

# Introduction

This image aims to provide a custom docker image with jenkins, a set of base plugins and a docker client.

# Usage

```
docker run -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins
```
