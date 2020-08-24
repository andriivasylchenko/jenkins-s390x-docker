# Running Jenkins in IBM LinuxONE Community Cloud OpenShift environment with WebSphere Application Server Liberty Profile
_The IBM LinuxONE Community Cloud is a no-charge, 24 x 7, enterprise-grade, open access, shared public cloud environment on IBM's LinuxONE III platform (s390x)_

You can request free trial for OpenShift Container Platform or provision a Virtual Machine on IBM LinuxONE Community Cloud [here](https://developer.ibm.com/components/ibm-linuxone/gettingstarted/)

---

This repository contains 2 docker files to use within Openshift environment to create a Jenkins instance.

## Dockerfile-full

Uses a full (pre-packaged with features) image of [WebSphere Application Server Liberty Profile](https://hub.docker.com/r/s390x/websphere-liberty) (usually called wlp or liberty) for s390x. Jenkins 2.235.4 war file downloaded from [official location](https://www.jenkins.io/download/) and placed into _dropins_ folder that is monitored for applications by default.
_jvm.options_ file copied from this repo with settings to:
* bypass initial _Unlock Jenkins_ screen (which forces users to get temp password from container runtime)
* set default _JENKINS_HOME_ location
* set maximum memory allocation pool (optional)
* avoid non-UTF text related errors (optional)

**Recommended**: If you want to have a persistent Jenkins configuration, mount a persistent storage to _JENKINS_HOME_ location as a mount point. In _jvm.options_ it is set to _/opt/jenkins_ 


## Dockerfile-kernel

Uses a kernel (base) image of [WebSphere Application Server Liberty Profile](https://hub.docker.com/r/s390x/websphere-liberty) (usually called wlp or liberty) for s390x and requires configuration based on provided _server.xml_. Jenkins 2.235.4 war file downloaded from [official location](https://www.jenkins.io/download/) and placed into _apps_ folder that is monitored for applications by default.
_jvm.options_ file copied from this repo with settings to:
* bypass initial _Unlock Jenkins_ screen (which forces users to get temp password from container runtime)
* set default _JENKINS_HOME_ location
* set maximum memory allocation pool (optional)
* avoid non-UTF text related errors (optional)

_server.xml_ file copied from this repo with settings to:
* initialize jenkins.war from _apps_ folder
* provide features list
* configure default server endpoint

_configure.sh_ script launched at the end to install features listed in _server.xml_

Argument _OPENJ9_SCC=false_ is set to ignore creation of SCC layer which takes a lot of resources and performs server stop && server start procedures twice.

**Recommended**: If you want to have a persistent Jenkins configuration, mount a persistent storage to _JENKINS_HOME_ location as a mount point. In _jvm.options_ it is set to _/opt/jenkins_  


## Dockerfile-kernel-addons

Same as [Dockerfile-kernel-addons](https://github.com/andriivasylchenko/s390x-jenkins-l1cc-openshift/blob/master/README.md#dockerfile-kernel) + additionally installing:
* NodeJS + NPM
* Git
