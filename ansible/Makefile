bundle-edge:
	ansible-playbook bundle.yaml --ask-vault-pass

pre-requisites:
	ansible-playbook pre-requisites.yaml --ask-vault-pass

install:
	ansible-playbook k3s-install.yaml --ask-vault-pass

uninstall:
	ansible-playbook k3s-uninstall.yaml --ask-vault-pass

shutdown:
	ansible-playbook shutdown.yaml --ask-vault-pass