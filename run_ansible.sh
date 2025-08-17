#!/bin/bash
ansible-playbook -i inventory/hosts --ask-vault-pass init.yml