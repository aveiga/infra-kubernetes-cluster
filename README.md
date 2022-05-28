# Airgap Infra-dedicated Kubernetes Edge Cluster

Ansible playbooks to setup an Airgap, HA [k3s](https://k3s.io) cluster Infrastructure components

## Ansible host pre-requisites

1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
1. Install the Ansible Docker Community collection: `ansible-galaxy collection install community.docker`
1. Install the Ansible Posix collection: `ansible-galaxy collection install ansible.posix`
<!-- 1. Install Python
1. Install the Python Docker library: `pip3 install docker`
1. Install the Python PyYaml library: `pip3 install pyyaml` -->

## Install Procedure

1. Customize the [hosts.yaml](./hosts.yaml) file to point to your nodes. The "master0\*" hosts are assumed to be control plane nodes.
1. `make pre-requisites`
1. `make install`

## Uninstall Procedure

1. `make uninstall`

## Full documentation

TBD

## Disclaimer

The provided code was tested on a 2020 M1 Macbook Air as the Ansible host and VirtualBox VMs running on a Windows host acting as the Kubernetes nodes.

## Other tips

- While setting up the VMs that would become the k8s nodes, I've started by creating a first machine and then cloning it once I was happy with it's setup. In order for the clones to be able to pickup an IP address, I've had to delete the `/etc/udev/rules.d/70-persistent-net.rules` file on each of them.
- Manually open the 6443 port on openSUSE: the playbooks are handling this, but while developing them I've tested it by running the following commands on all nodes ([source](https://www.cyberciti.biz/faq/set-up-a-firewall-using-firewalld-on-opensuse-linux/)):

```bash
sudo firewall-cmd --zone=public --add-port=6443/tcp --permanent
sudo firewall-cmd --reload
```

## To Do

- Gitlab (https://docs.gitlab.com/charts/quickstart/index.html)
- ArgoCD
- Rook (https://itnext.io/using-rook-on-a-k3s-cluster-8a97a75ba25e)
- minIO (https://docs.min.io/minio/k8s/deployment/deploy-minio-operator.html)
