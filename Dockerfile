FROM centos:8
LABEL maintainer="Dovry"
ENV container=docker
ENV script_url "https://raw.githubusercontent.com/Dovry/ansible-install-script/master/ansible_convenience_script.sh"

# Install systemd -- See https://hub.docker.com/_/centos/
RUN yum -y update; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install required packages
RUN yum makecache --timer \
  && yum -y install \
    sudo \
    wget 
    
# Install ansible
RUN wget $script_url \
  && chmod +x ansible_convenience_script.sh \
  && bash ./ansible_convenience_script.sh \
  && rm -f ansible_convenience_script.sh \
  && yum clean all \
  && echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
