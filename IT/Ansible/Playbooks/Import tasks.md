#                  What it is?

It is just a big peace of a Playbook (ansible script). It consists out of tasks: little peaces of a script.
















#              How to use them

```yaml
- name: Playbook name
  hosts: PC_name_from_hosts_file
  become: yes

	tasks:
	  - block:
	    - name: Task name
	      #? Static import
	      import_tasks: rolename.yaml
	    - name Task name
	      #? Dinamic import
	      include_tasks: for{{ ansible_os_family }}.yaml
```







