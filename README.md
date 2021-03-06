# Airgap Infra-dedicated Kubernetes Edge Cluster

Ansible playbooks to setup an Airgap, HA [k3s](https://k3s.io) cluster Infrastructure components

## VM Setup

- `cd terraform`
- If not done, create a `secret.tfvars` file with the following content:

```
sshkey_id = "<ID of the dev machine SSH key>"
token     = "<CIVO API Token>"
```

- When setting up the project for the first time, run `terraform init`. If upgrading the civo provider version, run `terraform init --upgrade` instead (provider version is updated in the `terraform/provider.tf` file and the latest version is defined [here](https://registry.terraform.io/providers/civo/civo/latest) - click "use provider")
- `make plan`
- `make apply`

## Kubernetes Setup

### Ansible host pre-requisites

1. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
1. Install the Ansible Docker Community collection: `ansible-galaxy collection install community.docker`
1. Install the Ansible Posix collection: `ansible-galaxy collection install ansible.posix`
1. Install the Ansible Kubernetes collection: `ansible-galaxy collection install kubernetes.core`
1. Install the Python PyYaml library: `pip3 install pyyaml`
1. Install the Python Kubernetes library: `pip3 install kubernetes`
<!-- 1. Install Python
1. Install the Python Docker library: `pip3 install docker`
1. Install the Python PyYaml library: `pip3 install pyyaml` -->

### Install Procedure

1. Customize the [hosts.yaml](./ansible/hosts.yaml) file to point to your nodes. The "master0\*" hosts are assumed to be control plane nodes.
1. `cd ansible`
1. `make pre-requisites`
1. `make install`

### Kubernetes Uninstall Procedure

1. `make uninstall`

### Shutdown all nodes

1. `make shutdown`

## VM Deletion

1. `cd terraform`
1. `make destroy`

## Full documentation

TBD

## Disclaimer

The provided code was tested on a 2020 M1 Macbook Air as the Ansible host and VirtualBox VMs running on a Windows host acting as the Kubernetes nodes.

## Other tips

### VM Clone

- While setting up the VMs that would become the k8s nodes, I've started by creating a first machine and then cloning it once I was happy with it's setup. In order for the clones to be able to pickup an IP address, I've had to delete the `/etc/udev/rules.d/70-persistent-net.rules` file on each of them.

### Rook

- In the process of setting Rook up, I've had to resize the VM disks for the worker nodes. To do it on VirtualBox, go to File -> Virtual Media Manager. Then, on openSUSE, run:

```bash
sudo zypper install growpart
sudo growpart /dev/sda 2
sudo btrfs filesystem resize max /mnt
```

- Also in the process of setting Rook up, I've had to add new unformatted disks (10Gi) to all worker nodes, to be used for ceph storage

- To verify rook status, bash into the toolbox pod by running `sudo kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash` and check rook status by running `ceph status`

### Access Argo CD

1. `ssh -L 8080:localhost:8080 master01`
1. `sudo kubectl port-forward svc/argocd-server -n argocd 8080:443`
1. `Access localhost:8080`
1. Username: `admin`
1. Password: `sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

## To Do

- Deploy the Trivy Operator by default
- ArgoCD
  - deploy minIO using an Application CRD
- Rook
  - understand how to recover previously used partitions

## Resources

- Gitlab (https://docs.gitlab.com/charts/quickstart/index.html)
- ArgoCD
- Rook (https://itnext.io/using-rook-on-a-k3s-cluster-8a97a75ba25e)
- minIO (https://docs.min.io/minio/k8s/deployment/deploy-minio-operator.html; https://github.com/minio/minio/blob/master/helm/minio/values.yaml)
