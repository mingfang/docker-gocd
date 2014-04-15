FROM ubuntu
 
RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu precise-updates universe' >> /etc/apt/sources.list && \
    apt-get update

#Runit
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y runit 
CMD /usr/sbin/runsvdir-start

#SSHD
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server &&	mkdir -p /var/run/sshd && \
    echo 'root:root' |chpasswd

#Utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim less net-tools inetutils-ping curl git telnet nmap socat dnsutils netcat tree htop unzip sudo

#Install Oracle Java 7
RUN apt-get install -y python-software-properties && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java7-installer

#Go Server
RUN wget http://download01.thoughtworks.com/go/13.4.1/ga/go-server-13.4.1-18342.deb && \
    dpkg -i go-server-13.4.1-18342.deb && \
    rm go-server-13.4.1-18342.deb

#Go Agent
RUN wget http://download01.thoughtworks.com/go/13.4.1/ga/go-agent-13.4.1-18342.deb && \
    dpkg -i go-agent-13.4.1-18342.deb && \
    rm go-agent-13.4.1-18342.deb

#Docker client only
RUN wget -O /usr/local/bin/docker https://get.docker.io/builds/Linux/x86_64/docker-latest && \
    chmod +x /usr/local/bin/docker

#Configuration
ADD . /docker

#Runit Automatically setup all services in the sv directory
RUN for dir in /docker/sv/*; do echo $dir; chmod +x $dir/run $dir/log/run; ln -s $dir /etc/service/; done

ENV HOME /root
WORKDIR /root
EXPOSE 22
