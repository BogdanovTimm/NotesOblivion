1. `sudo apt-get install ansible`
2. Create `hosts.yaml` file (see example in [[hosts.yaml Example]])
3. `ansible -i hosts.yaml all -m ping`
4. Create `ansible.cfg` file (see example in [[ansible.cfg Example]])
5. `ansible-inventory --list`
6. `ansible all -m ping`
7. Create `Playbook.yaml`
8. `ansible-playbook -vvvvv Playbook.yaml` - `ivvvv` means that you need a verbose output