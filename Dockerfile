# ================================================================================================================
#
# Jenkins instance with docker commands
#
# @see https://github.com/docker-library/docker
# @see https://hub.docker.com/_/docker/
# @see https://github.com/jenkinsci/docker
# @see https://hub.docker.com/_/jenkins/
# ================================================================================================================

# Base is a nginx install customized bye me
FROM jenkins:1.625.1

# Maintainer
MAINTAINER alban.montaigu@gmail.com

# To do maintainance operations
USER root

# Environment configuration
ENV DOCKER_BUCKET="get.docker.com" \
    DOCKER_VERSION="1.7.1" \
    DOCKER_SHA256="4d535a62882f2123fb9545a5d140a6a2ccc7bfc7a3c0ec5361d33e498e4876d5"

# System install required system components
RUN apt-get update \
    && apt-get install -y make git openssh-client \
    && rm -r /var/lib/apt/lists/*

# Adds docker client
# @see https://github.com/docker-library/docker/blob/6c4acc40ebc56a539fd33e7799187641dc1e27b0/1.7/Dockerfile
RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
    && echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
    && chmod +x /usr/local/bin/docker \
    && groupadd docker \
    && sudo gpasswd -a jenkins docker

# Jenkins configuration
COPY jenkins/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# drop back to the regular jenkins user - good practice
USER jenkins 
