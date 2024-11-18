#                  What it is?

You can import Ansible-Tasks form other Ansible-Playboks files.

There is 2 types of importing:
- `include_role`, `include_tasks`, `include_vars` - imoprted Ansible-Tasks, Ansible-Roles and Ansible-Variables can be changed by non-imported Ansible-Tasks, Ansible-Roles and Ansible-Variables. Added in Runtime. Slow
- `import_role`, `import_tasks` - imoprted Ansible-Tasks, Ansible-Roles and Ansible-Variables cannot be changed by non-imported Ansible-Tasks, Ansible-Roles and Ansible-Variables. Added in Pre-Process. Cannot be used in the Ansible-Playbook-Loop. Apply Ansible-Task-Options to all Ansible-Tasks within imported (very dumb behaviour). Fast















#                Create a new one

See [[External Task Example]]








#              How to use them

```yaml
---
- name: Playbook name
  hosts: PC_name_from_hosts_file
  become: yes

	tasks:
	  - block:
	    - name: Task name
	      #? Static import
	      import_tasks: Playbook.yaml
	    - name Task name
	      #? Dinamic import
	      include_tasks: for{{ ansible_os_family }}.yaml
```