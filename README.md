# Airgap Infra-dedicated Kubernetes Edge Cluster

Ansible playbooks to setup an Airgap, HA [k3s](https://k3s.io) cluster Infrastructure components

## Ansible host pre-requisites

1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
1. Install the Ansible Docker Community collection: `ansible-galaxy collection install community.docker`
1. Install Python
1. Install the Python Docker library: `pip3 install docker`
1. Install the Python PyYaml library: `pip3 install pyyaml`

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
