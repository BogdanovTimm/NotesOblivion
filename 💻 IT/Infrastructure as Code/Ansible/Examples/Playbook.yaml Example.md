```YAML
---
- name: Install and upgrade Nginx
  #? Name of a PC from 'hosts.yaml' file on which to do this Playbook
  hosts: part1
  #? Allows to use 'sudo'
  become: yes
  #? Defining a variables
  vars:
    source_file: indexVM2.html
    destin_file: /var/www/html/index.html
    
    
    
  tasks:
    - name: Check OS Version
      #? Actually it is System.output.println(var);
      debug:
        var: ansible_os_family

      #? if-statement ('when' = 'if') and yes, if here is written on the bottom
    - block:
      - name: Install Nginx
        yum:
          name: nginx
          state: latest
      - name: Copy Index.html
        copy:
          src: "{{ source_file }}"
          dest: "{{ destin_file }}"
          mode: 777
        notify: Restart Nginx
      - name: StartWebServer
        service: 
          name: nginx 
          state: started 
          enabled: yes
      when: ansible_os_family == "RedHat"

    - block:
      - name: While-loop
        shell: echo "Lorem Ipsum"
        #? Saves output from 'shell' as a variable
        register: output_from_shell_as_variable
        #? While-loop --v
        #? Try every 3 seconds
        delay: 3
        #? After which amount of tries to exit with error code
        retries: 10
        #? When to stop
        until: output_from_shell_as_variable.stdout.find("Lorem Ipsum") == false
        #? While-loop --^
      when: ansible_os_family == "Debian"

    - block:
      - name: Install Nginx
        apt:
          #? [item] is a scpeical variable name, that will be replaced by all values under a 'loop' keyword
          name: "{{ item }}"
          state: latest
        loop:
          - nginx
          - nano
          - less
      - name: Copy Index.html
        copy:
          src: "{{ source_file }}"
          dest: "{{ destin_file }}"
          mode: 777
        notify: Restart Nginx
      - name: StartWebServer
        service:
          name: nginx 
          state: started 
          enabled: yes
      when: ansible_os_family == "Debian"
  
  

  #? If one of tasks did something - then run it:
  #! If no task actually changed something - this will not be ran
  handlers:
    - name: Restart Nginx
      service: 
        name: nginx
        state: restarted
```