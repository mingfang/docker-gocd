FROM ubuntu:14.04
 
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
RUN echo "export PS1='\e[1;31m\]\u@\h:\w\\$\[\e[0m\] '" >> /root/.bashrc

#Runit
RUN apt-get install -y runit 
CMD export > /etc/envvars && /usr/sbin/runsvdir-start
RUN echo 'export > /etc/envvars' >> /root/.bashrc

#Utilities
RUN apt-get install -y vim less net-tools inetutils-ping wget curl git telnet nmap socat dnsutils netcat tree htop unzip sudo software-properties-common jq psmisc

#Install Oracle Java 8
RUN apt-get install -y python-software-properties && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer

#Go Server
RUN wget http://download.go.cd/gocd-deb/go-server-15.2.0-2248.deb && \
    dpkg -i go-server-*.deb && \
    rm go-server-*.deb

#Go Agent
RUN wget http://download.go.cd/gocd-deb/go-agent-15.2.0-2248.deb && \
    dpkg -i go-agent-*.deb && \
    rm go-agent-*.deb

#Docker client only
RUN wget -O /usr/local/bin/docker https://get.docker.io/builds/Linux/x86_64/docker-latest && \
    chmod +x /usr/local/bin/docker

#plugins
RUN mkdir -p /var/lib/go-server/plugins/external && \
    cd /var/lib/go-server/plugins/external && \
    wget https://github.com/srinivasupadhya/gocd-build-status-notifier/releases/download/1.1/github-pr-status-1.1.jar
RUN mkdir -p /var/lib/go-server/plugins/external && \
    cd /var/lib/go-server/plugins/external && \
    wget https://github.com/ashwanthkumar/gocd-build-github-pull-requests/releases/download/1.2/github-pr-poller-1.2.jar
RUN mkdir -p /var/lib/go-server/plugins/external && \
    cd /var/lib/go-server/plugins/external && \
    wget https://github.com/srinivasupadhya/email-notifier/releases/download/v0.1/email-notifier-0.1.jar

ADD etc/autoregister.properties /var/lib/go-agent/config/autoregister.properties

#Add runit services
ADD sv /etc/service 
