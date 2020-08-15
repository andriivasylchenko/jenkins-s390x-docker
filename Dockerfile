FROM s390x/websphere-liberty:full

WORKDIR /usr/src/app

USER root

RUN apt-get update

RUN apt-get install -y wget

RUN mkdir -p /jenkins && chown -R 1001:0 /jenkins

# RUN chown -R 1001:0 /usr/src/app

RUN wget -P /config/dropins/ http://mirrors.jenkins.io/war-stable/2.235.4/jenkins.war

RUN whoami

RUN pwd

RUN ls -la /config/dropins/

RUN ls -la /

#RUN --chown=1001:0 /config/dropins/jenkins.war

COPY --chown=1001:0  jvm.options /config/

RUN --chown=1001:0 -R /opt/ibm/wlp/usr/servers/defaultServer

USER 1001

# RUN wget -P /config/dropins/ https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
