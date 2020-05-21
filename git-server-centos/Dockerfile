FROM centos:centos7
LABEL maintainer="sanjay.ch.gupta@gmail.com"

# Install all dependency and tool
RUN yum -y update; yum clean all
RUN yum -y install git-core openssh-server passwd; yum clean all
RUN sed -Ei "s/^#PermitRootLogin.*/PermitRootLogin no/" /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

# Copy Utill script
COPY ./util-tools/docker-entrypoint.sh /docker-entrypoint.sh
# Copy Utill script use to create and delete remote repository.
COPY util-tools/create-repository.sh /bin/create-repository
COPY util-tools/delete-repository.sh /bin/delete-repository

RUN chmod +x docker-entrypoint.sh
RUN chmod +x /bin/create-repository
RUN chmod +x /bin/delete-repository

# Executing script to setup user(git), pass(git) and ssh setup 
RUN /docker-entrypoint.sh

# Default port for ssh
EXPOSE 22

# Volumes
VOLUME /home/git

ENTRYPOINT ["/usr/sbin/init"]
CMD ["systemctl"]