FROM openjdk:8u171-jdk-slim-stretch


RUN apt-get update && \
    apt-get install -y software-properties-common wget git nano

ENV ZOOKEEPER_VERSION 3.4.12

#Download Zookeeper
RUN wget -q http://mirror.vorboss.net/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz
#
#Install
RUN tar -xzf zookeeper-${ZOOKEEPER_VERSION}.tar.gz -C /opt
#
#Configure
RUN cp /opt/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo_sample.cfg /opt/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo.cfg
#
#Definindo a variável de ambiente para a versão do
ENV ZK_HOME /opt/zookeeper-${ZOOKEEPER_VERSION}
#
#Mudando a linha no arquivo
RUN sed  -i "s|/tmp/zookeeper|$ZK_HOME/data|g" $ZK_HOME/conf/zoo.cfg; mkdir $ZK_HOME/data

EXPOSE 2181 2888 3888

WORKDIR /opt

# RUN ./zookeeper-3.4.12/bin/zkServer.sh start-foreground
