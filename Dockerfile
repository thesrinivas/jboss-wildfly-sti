FROM jboss/wildfly:latest

USER root
#RUN yum -y install maven && yum clean all
USER jboss

#ENV STI_SCRIPTS_URL https://raw.githubusercontent.com/goldmann/openshift-jboss-wildfly/master/.sti
ENV STI_SCRIPTS_URL https://github.com/thesrinivas/jboss-wildfly-sti/.sti
