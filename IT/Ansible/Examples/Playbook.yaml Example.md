```YAML
---
- name: Playbook name
    hosts: part2
    become: yes
    vars:
        source_file: indexVM2.html
        destin_file: /var/www/html/index.html
    tasks:
        - name: Task name
            apt: name=nginx state=present
        - name: Task 2 name
            copy: serc={{ source_file:}} dest={{ destin_file }} mode=777
        - name: Task 3 name
            service:
                name: nginx
                state: started
                enabled: yes
```