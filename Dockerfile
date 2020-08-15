FROM s390x/websphere-liberty:kernel

WORKDIR /usr/src/app

USER root

RUN apt-get install wget

RUN chown -R 1001:0 /usr/src/app

USER 1001

RUN wget http://mirrors.jenkins.io/war-stable/2.235.4/jenkins.war /config/dropins/

COPY --chown=1001:0  server.xml /config/

RUN configure.sh
