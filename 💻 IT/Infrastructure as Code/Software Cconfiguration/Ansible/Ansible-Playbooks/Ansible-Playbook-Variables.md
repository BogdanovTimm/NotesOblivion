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