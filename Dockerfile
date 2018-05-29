FROM ubuntu:16.04
MAINTAINER Liang Ding <d@b3log.org>

RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse' > /etc/apt/sources.list\
    && echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list


RUN apt-get update && apt-get install -y wget git

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz
RUN tar zxvf jdk-8u161-linux-x64.tar.gz
ENV JAVA_HOME /jdk1.8.0_161
ENV PATH $PATH:$JAVA_HOME/bin
RUN echo '' >> /etc/profile \
    && echo '# JDK' >> /etc/profile \
    && echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile \
    && echo 'export PATH="$PATH:$JAVA_HOME/bin"' >> /etc/profile \
    && echo '' >> /etc/profile \
    && . /etc/profile

RUN wget http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.2.7.v20150116/jetty-distribution-9.2.7.v20150116.tar.gz
RUN tar zxvf jetty-distribution-9.2.7.v20150116.tar.gz && mv /jetty-distribution-9.2.7.v20150116 /jetty && rm -rf /jetty/webapps/*

RUN wget http://mirrors.shu.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
RUN tar zxvf apache-maven-3.5.2-bin.tar.gz && mv /apache-maven-3.5.2 /maven

ADD ./ /sym
# 需要修改成真实ip
RUN cd /sym && sed -i 's/localhost/fullstack.club/g' src/main/resources/latke.properties && sed -i 's/8080/80/g' src/main/resources/latke.properties && /maven/bin/mvn package -Dmaven.test.skip=true

RUN mv /sym/target/symphony.war /jetty/webapps/ROOT.war

WORKDIR /jetty
ENV JETTY_PORT 8080
RUN java -jar /jetty/start.jar --create-startd
RUN java -jar /jetty/start.jar --add-to-start=http,deploy

ADD scripts /opt
RUN chmod +x /opt/*

EXPOSE 8080
CMD sh /opt/boot.sh