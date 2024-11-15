# What it is?

...









# Terminology

Ansible-Playbook - a file that contains plays
Ansible-Playbook-Play - something like a funciton in programming. At minimum, Ansible-Playbook-Play consist of Ansible-Playbook-Task and list of PCs to execute it on
Ansible-Playbook-Task - Ansible-Module that performs some opertaion on remote PC









# Run Ansible-Playbook

`ansible-playbook --check x/PATH/TO/PLAYBOOKx.yml -f 10` where:
* `--check` - checks whether Ansible-Playbook can be ran on remote PC, but actually not execute it
* `-f 10` - specify how many parallel threads need to be create









# Folder structure

```
/xPATH/TO/PLAYBOOKx/Playbook.yaml
/xPATH/TO/PLAYBOOKx/ansible.cfg           # Configuration for Ansible-Playbook
/xPATH/TO/PLAYBOOKx/hosts.ini             # Configuration for Ansible-Inventory
/xPATH/TO/PLAYBOOKx/group_vars/xGROUP_1x/ # Variables for Ansible-Inventory-Groups
/xPATH/TO/PLAYBOOKx/host_vars/xHOST_1x/   # Variables for Ansible-Inventory-Hosts
/xPATH/TO/PLAYBOOKx/templates/            # Files.j2 for copying on Slave-PCs
```