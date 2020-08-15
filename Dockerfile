FROM s390x/websphere-liberty:kernel

WORKDIR /usr/src/app

USER root

RUN apt-get update

RUN apt-get install -y wget

RUN chown -R 1001:0 /usr/src/app

USER 1001

RUN wget -P /config/dropins/ http://mirrors.jenkins.io/war-stable/2.235.4/jenkins.war

RUN mkdir jenkins

COPY --chown=1001:0  server.xml /config/
COPY --chown=1001:0  jvm.options /config/

ARG VERBOSE=true

RUN configure.sh
