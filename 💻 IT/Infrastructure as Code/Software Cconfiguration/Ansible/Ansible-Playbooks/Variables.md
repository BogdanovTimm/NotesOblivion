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