FROM centos:8
LABEL maintainer="Dovry"
ENV container=docker
ENV script_url "https://raw.githubusercontent.com/Dovry/ansible-install-script/master/ansible_convenience_script.sh"

# Install required packages
RUN yum makecache --timer \
  && yum -y install wget \
  # Run ansible convenience script
  && wget --no-check-certificate -O - $script_url | bash -s -- -p \
  && yum clean all

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
HEALTHCHECK CMD ansible --version