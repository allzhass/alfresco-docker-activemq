# Alfresco Anaxes Shipyard ActiveMQ Image
#
# Version 0.1

# This is an initial iteration and subject to change
FROM quay.io/alfresco/alfresco-base-java:8u181-oracle-centos-7-fbda83b9c4da

LABEL name="Alfresco ActiveMQ" \
    vendor="Alfresco" \
    license="Various" \
    build-date="unset"

ENV ACTIVEMQ_HOME="/opt/activemq"
ENV ACTIVEMQ_BASE="/opt/activemq"
ENV ACTIVEMQ_CONF="/opt/activemq/conf"
ENV ACTIVEMQ_DATA="/opt/activemq/data"

ENV ACTIVEMQ_VERSION="5.15.6"
ENV DOWNLOAD_URL="http://apache.mirrors.ovh.net/ftp.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz"

RUN mkdir -p ${ACTIVEMQ_HOME} /data /var/log/activemq  && \
    curl ${DOWNLOAD_URL} -o /tmp/activemq.tar.gz && \
    tar -xzf /tmp/activemq.tar.gz -C /tmp && \
    mv /tmp/apache-activemq-${ACTIVEMQ_VERSION}/* ${ACTIVEMQ_HOME} && \
    rm -rf /tmp/activemq.tar.gz

# Web Console
EXPOSE 8161
# OpenWire
EXPOSE 61616
# AMQP
EXPOSE 5672
# STOMP
EXPOSE 61613

VOLUME ["${ACTIVEMQ_DATA}"]
VOLUME ["/var/log/activemq"]
VOLUME ["${ACTIVEMQ_CONF}"]

WORKDIR ${ACTIVEMQ_HOME}
ADD init.sh ${ACTIVEMQ_HOME}
CMD ./init.sh ${ACTIVEMQ_HOME}
