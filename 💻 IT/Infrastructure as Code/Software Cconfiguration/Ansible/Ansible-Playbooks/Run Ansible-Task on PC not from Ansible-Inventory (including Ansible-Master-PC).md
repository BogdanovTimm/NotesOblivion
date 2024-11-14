# What it is?

Sometimes you need to run an Ansible-Task on the PC that is not in Ansible-Inventory. And sometimes you need to run an Ansible-Task on the Ansible-Master-PC.









# How to do it?

## Run Ansile-Playbook.yml on PC not in Ansible-Inventory

```yaml
- name: xPLAY_1x
  hosts: xHOST_OR_GROUP_OF_HOSTSx
  tasks:
    - name: xTASK_1x
      ansible.builtin.add_host:
        name: '{{ ip_from_ec2 }}'
        groups: xANSIBLE_INVENTORY_GROUPx
```









## Run Ansile-Playbook.yml on Ansible-Master-PC

You can do it using either syntax within Ansible-Playbook:
* If you need to run Ansible-Tasks only on the localhost, without working with any remote host. Also, for this to work, you need to set `ansible_python_interpreter: “{{ ansible_playbook_python }}”` in `/xPATH/TO/PLAYBOOKx/host_vars/localhost.yml`:
    * Using `hosts:127.0.0.1` + `connection:local` - but this way you can't do any remote Ansible-Tasks
    ```yaml
      - name: xPLAY_1x
        hosts: 127.0.0.1
        conneciton: local
        tasks:
          - name: xTASK_FOR_MASTER_PCx                         # {{inventory_hostname}} == Ansible-Slave-PC...
            xANSIBLE.MODULEx: xCOMMANDx {{inventory_hostname}} #      ...on which command is executed
            delegate_to: 127.0.0.1
          - name: xTASK_FOR_OTHERSx
            xANSIBLE.MODULEx: xCOMMANDx
    ```
    * `ansible-playbook x/PATH/TO/PLAYBOOKx.yml --connection=local` - but this way you can't do any remote Ansible-Tasks
* If you need to work not only with localhost, but also with remote hosts:
    * `name:tasks:xANSIBLE_MODULEx:delegate_to: xHOSTx`:
        ```yaml
        - name: xPLAY_1x
          hosts: xHOST_OR_GROUP_OF_HOSTSx
          tasks:
            - name: xTASK_FOR_MASTER_PCx                         # {{inventory_hostname}} == Ansible-Slave-PC...
              xANSIBLE.MODULEx: xCOMMANDx {{inventory_hostname}} #      ...on which command is executed
              delegate_to: 127.0.0.1
            - name: xTASK_FOR_OTHERSx
              xANSIBLE.MODULEx: xCOMMANDx
        ```
    * `name:tasks:local_action: xMODULEx xCOMMANDx`:
      ```yaml
      - name: xPLAY_1x
        hosts: xHOST_OR_GROUP_OF_HOSTSx
        tasks:
          - name: xTASK_FOR_MASTER_PCx                                      # {{inventory_hostname}} == Ansible-Slave-PC...
            local_action: xANSIBLE.MODULEx xCOMMANDx {{inventory_hostname}} #      ...on which command is executed
          - name: xTASK_FOR_OTHERSx
            xANSIBLE.MODULEx: xCOMMANDx
      ```









### Copy a file from Ansible-Master-PC to the Ansible-Slave-PC

```yaml
- name: xPLAY_1x
  hosts: xHOST_OR_GROUP_OF_HOSTSx
  tasks:
    - name: xTASK_1x
      local_action: ansible.builtin.command rsync -a /xPATH/ON/MASTER/PC/TO/FILE.TXTx {{inventory_hostname}}:/xPATH/ON/SLAVE/PCsx
```