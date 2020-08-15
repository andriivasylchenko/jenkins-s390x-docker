FROM s390x/websphere-liberty:full

WORKDIR /opt/jenkins

USER root

RUN apt-get update

RUN apt-get install -y wget

# RUN chown -R 1001:0 /usr/src/app

RUN wget -P /config/dropins/ http://mirrors.jenkins.io/war-stable/2.235.4/jenkins.war

RUN chown -R 1001:0 /config/dropins/jenkins.war

RUN whoami

RUN pwd

RUN ls -la

RUN ls -la /config/dropins/

RUN ls -la /

COPY jvm.options /config/

RUN chown -R 1001:0 /opt/jenkins

RUN ls -la /opt/jenkins

USER 1001

# RUN wget -P /config/dropins/ https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
