# ====================================================
#
# Jenkins instance with docker commands
#
# @see https://github.com/docker-library/docker
# @see https://hub.docker.com/_/docker/
# @see https://github.com/jenkinsci/docker
# @see https://hub.docker.com/_/jenkins/
# ====================================================

# Base is a nginx install customized bye me
FROM jenkins:2.32.1

# Maintainer
MAINTAINER alban.montaigu@gmail.com

# To do maintainance operations
USER root

# Environment configuration
ENV DOCKER_VERSION="1.12.2" \
    DOCKER_COMPOSE_VERSION="1.9.0"

# System install required system components
RUN apt-get update \
    && apt-get install -y make git openssh-client python-pip \
    && rm -r /var/lib/apt/lists/* \

# Install docker bin for client commands (will be connected to docker host daemon)
    && curl -fSL "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
    && tar xvzf docker.tgz \
    && mv -fv docker/docker /usr/local/bin/docker \
    && chmod +x /usr/local/bin/docker \
    && rm -rvf docker* \

# Install docker compose
    && pip install -U pip docker-compose==$DOCKER_COMPOSE_VERSION

# Jenkins configuration
COPY jenkins/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY jenkins/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
