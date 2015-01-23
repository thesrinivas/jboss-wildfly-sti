FROM jboss/wildfly:latest

USER root
RUN yum -y install maven && yum clean all
USER jboss

ADD .sti/ /sti/
ENV STI_SCRIPTS_URL image:///sti/
CMD ["/sti/usage"]
