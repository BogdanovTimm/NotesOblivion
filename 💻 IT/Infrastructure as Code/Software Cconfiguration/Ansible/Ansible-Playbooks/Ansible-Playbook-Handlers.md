# What it is?

You can run other Ansible-Tasks (that will now be called Ansible-Handlers) from Ansible-Tasks either:
- By Ansible-Handler-Group defined by `listen` keyword (use this way, because you will not be constrained by unique Ansible-Handlers names):
    ```yaml
    ---
    - name: xPLAYx
      hosts: xHOSTx
      tasks:
        - name: xTASK_1x
          ansible.builtin.template:
            src: x/PATH/ON/MASTER/PC/TO/FILE.j2x
            dest: x/PATH/ON/SLAVE/PC/TO/FILE.confx
          notify:              # Run Ansible-Handlers. By default they'll be called after all Ansible-Tasks in Ansible-Play. 
            - xHANDLER-GROUPx  #      ...You can use [meta: flusj_handlers] to run them between Ansible-Tasks

        - name: xTASK_2x       # Run Ansible-Handlers now instead of after [xTASK_3x].
          meta: flush_handlers # Now you can trigger this Ansible-Handlers again later.

        - name: xTASK_3x
          ansible.builtin.template:
            src: x/PATH/ON/MASTER/PC/TO/FILE.j2x
            dest: x/PATH/ON/SLAVE/PC/TO/FILE.confx
      handlers:
        - name: xHANDLER_1x
          ansible.builtin.service:
            name: xPACKAGEx
            state: restarted
          listen: xHANDLER-GROUPx # [listen] can't contain {{ xVARIABLEx }}
        - name: xHANDLER_2x
          ansible.builtin.service:
            name: xPACKAGEx
            state: restarted
          listen: xHANDLER-GROUPx
    ```
- By Ansible-Handler names:
    ```yaml
    ---
    - name: xPLAYx
      hosts: xHOSTx
      tasks:
        - name: xTASKx
          ansible.builtin.template:
            src: x/PATH/ON/MASTER/PC/TO/FILE.j2x
            dest: x/PATH/ON/SLAVE/PC/TO/FILE.confx
          notify: # Run Ansible-Handlers by their names
            - xHANDLER_2x # Ansible-Handlers will be called in order in which...
            - xHANDLER_1x #      ...they are defined in [handlers] seciton, not here
      handlers:
        - name: xHANDLER_1x
          ansible.builtin.service:
            name: xPACKAGEx
            state: restarted
        - name: xHANDLER_2x
          ansible.builtin.service:
            name: xPACKAGEx
            state: restarted
    ```