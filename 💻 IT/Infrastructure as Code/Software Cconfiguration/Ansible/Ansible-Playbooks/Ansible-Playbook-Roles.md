# What it is?

Ansible-Playbook-Roles is just a simple Ansible-Playbook that is divided on separate files









# Default directory for roles

Ansible searches for Ansible-Playbook-Roles in next directories:
- ~/.ansible/roles
- /usr/share/ansible/roles
- /etc/ansible/roles
- /xPATH/TO/PLAYBOOKx/roles









# Role structure

```
Playbook.yaml
roles/
    xROLE_1x/
        tasks/          # Tasks. Ansible auto-includes main.yml founded in this folder
        handlers/       # Handlers. Ansible auto-includes main.yml founded in this folder
        templates/      # Files that need templating (.j2). Ansible auto-includes main.yml founded in this folder
        files/          # Files that do not need templating. Ansible auto-includes main.yml founded in this folder
        vars/           # Variables. Ansible auto-includes main.yml founded in this folder
            xGROUP_OF_VARIABLES_1x/
            xGROUP_OF_VARIABLES_2x/
        defaults/       # A role’s own variables will take priority over other role’s defaults, 
            xGROUP_OF_DEFAULT_VARIABLES_1x/
            xGROUP_OF_DEFAULT_VARIABLES_2x/
                        # but any/all other variable sources will override this. Ansible auto-includes main.yml founded in this folder
        meta/           # Role dependencies. Ansible auto-includes main.yml founded in this folder Metadata for the role, including role 
                        # dependencies and optional Galaxy metadata such as platforms supported. This is required for
                        # uploading into galaxy as a standalone role, but not for using the role in your play.
        library/        # Custom modules
        module_utils/   # Custom module_utils
        lookup_plugins/ # Custom plugins
```









# Import Ansible-Playbook-Role into an Ansible-Playbook

You can import Ansible-Playbook-Roles into yours:
- Ansible-Playbook:
    ```yaml
    ---
    - hosts: xHOSTNAMESx
      roles:
        - role: '/xPATH/TO/ROLESx'
    ```
- Ansible-Playbook-Tasks using `import role` or `include_role`
- as dependency









# Order of executing

Order of executing:
1) `pre_tasks` defined in the Ansible-Playbook-Play
2) Ansible-Handlers triggered by `pre_tasks`.
3) Each role listed in roles:, in the order listed. Any role dependencies defined in the role’s meta/main.yml run first, subject to tag filtering and conditionals. See Using role dependencies for more details.
4) Ansible-Playbook-Tasks defined in the Ansible-Playbook-Play
5) Ansible-Handlers triggered by the roles or tasks.
6) Any post_tasks defined in the play.
7) Ansible-Handlers triggered by post_tasks.