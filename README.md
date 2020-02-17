# Docker centos 8 ansible

![Build Status](https://github.com/dovry/docker_centos8_ansible/workflows/Basic%20build%20and%20push%20to%20Docker%20hub/badge.svg)

![Docker Pulls](https://img.shields.io/docker/pulls/dovry/docker_centos8_ansible)

Used to test ansible in a Centos 8 container

## How to use the container

```yaml
docker run --rm -d -it \
--name centos8_ansible \
-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v /run/lock:/run/lock:ro \
-v /etc/ansible:/etc/ansible:ro \
dovry/docker_centos8_ansible:latest
```

And then either exec into the container and start hacking away with:

`docker exec -it centos8_ansible /bin/bash`

or execute a role directly with a command such as this:

`docker exec -it centos8_ansible ansible-playbook /etc/ansible/playbooks/test-role.yml`

Remember to set the target host in the playbook so that it is run in the container

`hosts: localhost`