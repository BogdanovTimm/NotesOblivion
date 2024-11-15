# What it is?

Ansible-Playbook may handle errors:
- non-zero codes from execution of applicaitons in the shell
- Slave-PC is unreachable









# Code

## Define what will be counter as a failure

You may define what defines as a failure:
```yaml
---
- name: xPLAYx
  hosts: xHOSTx
  tasks:
    - name: xTASK_1x
      ansible.builtin.command: xCOMMANDx
      register: xVARIABLE_1x
      failed_when: "'FAILED' in xVARIABLE_1x.stderr"
    - name: xTASK_2x
      ansible.builtin.command: xCOMMANDx
      register: xVARIABLE_2x
      failed_when: >
        (xVARIABLE_2x.rc == 0) or
        (xVARIABLE_2x.rc >= 2)
```

## Non-zero execution code

When Ansible encounters an error, it can either:
- (Default) Stop running Ansible-Play on the Slave-PC that have encountered an error and run this Ansible-Task on other Slave-PC
- Just ingonre it and go further:
    ```yaml
    ---
    - name: xPLAYx
      hosts: xHOSTx
      tasks:
        - name: xTASK_1x
          ansible.builtin.template:
            src: x/PATH/ON/MASTER/PC/TO/FILE.j2x
            dest: x/PATH/ON/SLAVE/PC/TO/FILE.confx
          ignore_errors: true # Ignore non-zero Linux-Return_Code
          ignore_unreachable: true # Ignore that Slave-PC is unreachable
    ```









## Host is unreachable

When Ansible encounters an unreachable Ansible-Slave-PC, it can either:
- (Default) Stop running Ansible-Play on the Slave-PC that is unreahable and run this Ansible-Task on other Slave-PC. Ansible-Playbook-Run will not try to run Ansible-Playbook-Tasks on the unreachable Ansible-Slave-PC. You can force it to forget that some Ansible-Slave-PC in unreachable by using:
    ```yaml
    ---
    - name: xPLAYx
      hosts: xHOSTx
      tasks:
        - name: xTASK_1x
          ansible.builtin.template:
            src: x/PATH/ON/MASTER/PC/TO/FILE.j2x
            dest: x/PATH/ON/SLAVE/PC/TO/FILE.confx
        - name: xTASK_2x
          meta: clear_host_errors # Forget that Slave-PC were unreachable
    ``` 
- Just ingonre it and go further:
    ```yaml
    ---
    - name: xPLAYx
      hosts: xHOSTx
      tasks:
        - name: xTASK_1x
          ansible.builtin.template:
            src: x/PATH/ON/MASTER/PC/TO/FILE.j2x
            dest: x/PATH/ON/SLAVE/PC/TO/FILE.confx
          ignore_unreachable: true # Ignore that Slave-PC is unreachable
    ```









## Errors and Ansible-Playbook-Handlers

When Ansible encounters any error on Ansible-Slave-PC on some Ansible-Playbook-Task, it can either:
- (Default) Stop running Ansible-Play and do not run any Ansible-Playbook-Handlers
- Run all activated Ansible-Playbook-Handlers by either:
    - `ansible --force-handlers`
    - Writing into your Ansibe-Playbook:
        ```yaml
        ---
        - name: xPLAYx
          hosts: xHOSTx
          force_handlers: True # Call Ansible-Plybook-Handlers even if ANsible-Playbook-Task will fail
          tasks:
            - name: xTASK_THAT_WILL_FAILx
              ansible.builtin.template:
                src: x/PATH/ON/MASTER/PC/TO/FILE.j2x
                dest: x/PATH/ON/SLAVE/PC/TO/FILE.confx
          handlers:
          - name: xHANDLER_THAT_WILL_BE_CALLEDx
            ansible.builtin.service:
              name: xPACKAGEx
              state: restarted
        ```
    - adding `force_handlers = True` to your ansible.cgf