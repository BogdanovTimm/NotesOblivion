# Save output from executing a command on Slave PC as a Ansible-Playbook-Variable

## Using Ansible-Playbook-Facts

```yaml
---
- name: xPLAY_1x
  tasks:
    - name: xTASKx
      shell: echo "Lorem Ipsum" # Save output from this Ansible-Module into...
      register: xNEW_VARIABLEx  #      ...this Ansible-Playbook-Variable
```









#           Use variable

```yaml
---
- name: xPLAY_1x
  tasks:
    - name: xTASK_1x
	    copy:
	      src: "{{ xEXISTING-VARIABLEx }}"                       # Variant 1
	      dest: x/PATH/ON/SLAVE/PCx
	      mode: x777x
	    notify: Restart Nginx
    - name: xTASK_2x
        ansible.builtin.shell: echo "motd contains the word hi"
        when: {{ xEXISTING_VARIBLEx.stdout.find('hi') }} != -1 # Variant 2
    - name: xTASK_3x
        xANSIBLE.MODULEx: xCOMMANDx
        when: {{ xEXISTING_VARIBLEx.stdout.split() }}          # Variant if you want to transform it into a list
```









# Linux-Environmet_Variables

Something like `xENVIRONMENT_VARIABLEx=xVALUEx xCOMMANDx` you can write in Ansible-Playbook as:
- For Ansible-Playbook-Task only:
    ```
    ---
    - name: xPLAY_1x
      tasks:
        - name: xTASK_1x
    	    ansible.builtin.shell: xCOMMANDx
          environment:
            xENVIRONMET_VARIABLEx: xVALUEx
    ```
- For whole Ansible-Playbook only:
    ```
    ---
    - name: xPLAY_1x
      environment:
        xENVIRONMET_VARIABLEx: xVALUEx
      tasks:
        - name: xTASK_1x
    	    ansible.builtin.shell: xCOMMANDx
    ```









## Get Linux-Environment_Variable from Ansible-Slave-PC

Sometimes you need to get a Linux-Environment_Variable from Ansible-Slave-PC to Ansible-Slave-PC.

Use `hostvars[xHOSTx]['xENVIRONMENT_VARIABLEx']`









# Use variables from a file

You may either:
- Define which file to use in Ansible-Playbook file:
    ```yaml
    ---
    - name: xPLAY_1x
      vars_files:
        - /xPATH/TO/VARIABLES/x.yml
      tasks:
        - name: xTASK_1x
          ansible.builtin.shell: xCOMMANDx
          environment:
            xENVIRONMET_VARIABLEx: xVALUEx
    ```
- `ansible-playbook    --extra-vars  "@x/PATH/TO/FILEx.yaml"    x/PATH/TO/PLAYBOOKx.yml` - Define which file to use in coomand line while `ansible-playbook`:
    









# Use variables from a command line

You may give Ansible a variable by either:
- `ansible-playbook    --extra-vars  "xVARIABLE1x=xVALUE1x  xVARIABLE2x=xVALUE2x"    x/PATH/TO/PLAYBOOKx.yml`
- `ansible-playbook    --extra-vars  '{"xVARIABLE1x":"xVALUE1x",  "xVARIABLE2x":"xVALUE2x"}'    x/PATH/TO/PLAYBOOKx.yml`





# Ansible-Variables precedence

1. command line values (for example, -u my_user, these are not variables)
2. role defaults (as defined in Role directory structure) 1
3. inventory file or script group vars 2
4. inventory group_vars/all 3
5. playbook group_vars/all 3
6. inventory group_vars/* 3
7. playbook group_vars/* 3
8. inventory file or script host vars 2
9. inventory host_vars/* 3
10. playbook host_vars/* 3
11. host facts / cached set_facts 4
12. play vars
13. play vars_prompt
14. play vars_files
15. role vars (as defined in Role directory structure)
16. block vars (only for tasks in block)
17. task vars (only for the task)
18. include_vars
19. set_facts / registered vars
20. role (and include_role) params
21. include params
22. extra vars (for example, -e "user=my_user")(always win precedence)