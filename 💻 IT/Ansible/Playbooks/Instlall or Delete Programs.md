#                Install

```yaml
---
- name: Playbook name
  hosts: slave_name_from_hosts_yaml_file
  #? Allows to use 'sudo'
  become: yes
  tasks:
    - name: Task name
      apt:
        name: nginx
        state: latest
```










# Delete

```yaml
---
- name: Playbook name
  hosts: slave_name_from_hosts_yaml_file
  #? Allows to use 'sudo'
  become: yes
  
  tasks:
    - name: Task name
      apt:
        name: nginx
        state: absent
```