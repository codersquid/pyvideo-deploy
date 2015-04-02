.PHONY: all

SHELL = /bin/sh

# This Makefile requires a clone of the richard-ansible repository in
# this directory. That holds the roles used in the playbook pyvideo.yml.
RICHARD_ANSIBLE = richard-ansible

# This Makefile requires a secret.yml file which holds variable values
# that are secret and shouldn't be checked into source control.
SECRET_FILE = secret.yml

help:
	@echo "Valid rules: dev, prod, setup."

# This rule checks the environment to make sure that richard-ansible
# is cloned and that secret.yml exists. Otherwise doing anything more
# is doomed to failure.
environ-check:
ifeq ($(wildcard $(RICHARD_ANSIBLE)), )
	$(error You need to run "make setup".)
endif
ifeq ($(wildcard $(SECRET_FILE)), )
	$(error You need to get a copy of secret.yml.)
endif

# For deployments to dev.pyvideo.org.
dev: environ-check
	ansible-playbook \
	    -i inventories/pyvideo \
	    --limit dev \
	    --extra-vars=DJANGO_CONFIGURATION=DevPyvideo \
	    pyvideo.yml

# For deployments to pyvideo.org.
prod: environ-check
	ansible-playbook \
	    -i inventories/pyvideo \
	    --limit prod \
	    pyvideo.yml

# To set up the environment.
setup:
ifeq ($(wildcard $(RICHARD_ANSIBLE)), )
	git clone https://github.com/pyvideo/richard-ansible
endif
ifeq ($(wildcard $(SECRET_FILE)), )
	@echo "You need to get a copy of secret.yml."
endif
