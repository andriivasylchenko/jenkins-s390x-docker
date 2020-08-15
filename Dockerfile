# FROM s390x/websphere-liberty:full

FROM s390x/websphere-liberty:kernel

USER root

RUN mkdir -p /opt/jenkins && chmod g+rwx /opt/jenkins

RUN apt-get update

RUN apt-get install -y wget

RUN wget -P /config/dropins/ http://mirrors.jenkins.io/war-stable/2.235.4/jenkins.war

RUN chown -R 1001:0 /config/dropins/jenkins.war

COPY --chown=1001:0 jvm.options /config/

COPY --chown=1001:0 server.xml /config/

RUN configure.sh

USER 1001

# RUN wget -P /config/dropins/ https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
