```YAML
---
- name: Install and upgrade Nginx
    hosts: part2
    become: yes
    vars:
        source_file: indexVM2.html
        destin_file: /var/www/html/index.html
    tasks:
        - name: Check OS Version
            debug: var=ansible_os_family
        - name: Install Nginx
            apt: name=nginx state=latest
            when: ansible_os_family == "Debian" # This task will be called only if ansible os family if debian
        - name: Copy Index.html
            copy: src={{ source_file }} dest={{ destin_file }} mode=777
            notify: Restart Nginx
            when: ansible_os_family == "Debian"
        - name: StartWebServer
            service: name=nginx state=started enabled=yes
            when: ansible_os_family == "Debian"


        handlers:
        - name: Restart Nginx
            service: name=nginx state=restarted



---
- name: Install and upgrade Nginx
    hosts: part2
    become: yes
    vars:
        source_file: indexVM2.html
        destin_file: /var/www/html/index.html
    
    
    
    tasks:
        - name: Check OS Version
            debug: var=ansible_os_family
        
        - block: #? if-statement ('when' = 'if') and yes, if here is written on the bottom
            - name: Install Nginx
                yum: name=nginx state=latest
            - name: Copy Index.html
                copy: src={{ source_file }} dest={{ destin_file }} mode=777
                notify: Restart Nginx
            - name: StartWebServer
                service: name=nginx state=started enabled=yes
        when: ansible_os_family == "RedHat"
        
        - block:
            - name: Install Nginx
                apt: name=nginx state=latest
            - name: Copy Index.html
                copy: src={{ source_file }} dest={{ destin_file }} mode=777
                notify: Restart Nginx
            - name: StartWebServer
                service: name=nginx state=started enabled=yes
        when: ansible_os_family == "Debian"
  
  

    #? If one of tasks did something - then run it:
    #! If no task actually changed something - this will not be ran
    handlers:
        - name: Restart Nginx
            service: name=nginx state=restarted
```