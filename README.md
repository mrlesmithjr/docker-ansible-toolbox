# docker-ansible-toolbox

This repo is for creating a usable [Docker](https://www.docker.com) image for
running [Ansible](https://ansible.com) related tasks from. This image uses [Alpine](https://alpinelinux.org) Linux as the base image and then installs
various usable versions of [Ansible](https://ansible.com) within Python virtual
environments.

## Building

Update the following in `setup_python_virtualenvs.sh` to include whichever
[Ansible](https://ansible.com) versions you would like:

```bash
ANSIBLE_VERSIONS=("1.9.4" "1.9.5" "1.9.6" "2.0.0.0" "2.0.0.1" "2.0.0.2" \
    "2.0.1.0" "2.0.2.0" "2.1.0.0" "2.1.1.0" "2.1.2.0" \
    "2.1.3.0" "2.1.4.0" "2.1.5.0" "2.1.6.0" "2.2.0.0" "2.2.1.0" \
    "2.2.2.0" "2.2.3.0" "2.3.0.0" "2.3.1.0" "2.3.2.0" "2.3.3.0" \
  "2.4.0.0" "2.4.1.0" "2.4.2.0")
```

Build image:

```bash
docker build -t ansible-toolbox .
```

## Usage

When you launch a container from this image you will be logged in as the user
`ansible` within the `/home/ansible` directory.
To run without building:

```bash
docker run -it mrlesmithjr/ansible-toolbox
```

To run after building:

```bash
docker run -it ansible-toolbox

ls
...
ansible                      python-virtualenvs           setup_python_virtualenvs.sh

ls python-virtualenvs/
...
ansible-1.9.4    ansible-1.9.6    ansible-2.0.0.1  ansible-2.0.1.0  ansible-2.1.0.0  ansible-2.1.2.0  ansible-2.1.4.0  ansible-2.2.1.0
ansible-1.9.5    ansible-2.0.0.0  ansible-2.0.0.2  ansible-2.0.2.0  ansible-2.1.1.0  ansible-2.1.3.0  ansible-2.2.0.0
```

Select the version of [Ansible](https://ansible.com) you would like to use:

```bash
source python-virtualenvs/ansible-2.2.1.0/bin/activate
(ansible-2.2.1.0) ~ $
```

Show the [Ansible](https://ansible.com) version:

```bash
ansible --version
ansible 2.2.1.0
  config file =
  configured module search path = Default w/o overrides
```

Mounting existing [Ansible](https://ansible.com) roles/playbooks/inventory and etc.
within the container for usage:

Mount a volume within the current directory to manage [Ansible](https://ansible.com)
roles/playbooks/inventory and etc.

```bash
docker run -it -v $(pwd)/.data/ansible:/home/ansible/ansible mrlesmithjr/ansible-toolbox
```

Mount a volume using an existing directory of [Ansible](https://ansible.com)
roles/playbooks/inventory and etc.

```bash
docker run -it -v ~/Git_Projects/GitHub/mrlesmithjr:/home/ansible/ansible mrlesmithjr/ansible-toolbox

ls ansible/
...
30-days-of-commitmas-2015              ansible-gocd                           ansible-playbooks-chaperone            docker-ansible-graylog
Ansible                                ansible-grafana                        ansible-plex                           docker-ansible-haproxy
Couch_to_OpenStack                     ansible-graphite                       ansible-postfix                        docker-ansible-influxdb
Graphite_Collectd                      ansible-graylog                        ansible-postgresql                     docker-ansible-jenkins
Logstash_Kibana3                       ansible-hadoop                         ansible-powerdns                       docker-ansible-kea-dhcp
PowerCLI_Scripts                       ansible-haproxy                        ansible-powerdns-authoritative         docker-ansible-keepalived
aci-ansible                            ansible-hashicorp-toolbox              ansible-powerdns-dnsdist               docker-ansible-kibana
acitoolkit                             ansible-influxdb                       ansible-powerdns-recursor              docker-ansible-logstash
ansible-aci                            ansible-inventory                      ansible-prometheus                     docker-ansible-logstash-pre-processor
ansible-apache2                        ansible-iperf                          ansible-quagga                         docker-ansible-logstash-processor
ansible-apf-firewall                   ansible-iptables                       ansible-rabbitmq                       docker-ansible-mongodb
ansible-apt-cacher-ng                  ansible-isc-dhcp                       ansible-rancid-git                     docker-ansible-mysql
ansible-apt-mirror                     ansible-iscsitarget                    ansible-redis                          docker-ansible-nagios
ansible-base                           ansible-jekyll                         ansible-role-chaperone                 docker-ansible-nginx
ansible-bashrc                         ansible-jenkins                        ansible-rsyslog                        docker-ansible-nginx-lb
ansible-bind                           ansible-jmeter                         ansible-rundeck                        docker-ansible-phpipam
ansible-bootstrap
```

`/home/ansible/.ssh` volume has been added as a possible volume mount that you
may want to utilize as well for things such as:

-   ssh keys
-   ssh known hosts
-   etc.

Mounting a volume for ssh related files within the current directory:

```bash
docker run -it -v $(pwd)/.data/.ssh:/home/ansible/.ssh mrlesmithjr/ansible-toolbox
```

Now you can generate your SSH keys and add hosts to known_hosts to persist
even if the container is destroyed.

## License

BSD

## Author Information

Larry Smith Jr.

-   [@mrlesmithjr](https://www.twitter.com/mrlesmithjr)
-   [EverythingShouldBeVirtual](http://everythingshouldbevirtual.com)
-   [mrlesmithjr@gmail.com](mrlesmithjr@gmail.com)
