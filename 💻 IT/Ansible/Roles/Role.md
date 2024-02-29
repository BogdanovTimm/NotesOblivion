# What it is?

Roles is a little parts of a Playbookname.yaml. Different from [[Import tasks]], roles have their structure with variables, hendlers, etc.








# Creating a new one
1. `mkdir roles && cd roles` - creating a `roles` folder
2. `ansible-galaxy init new_role_name`









#                  Structure of role repository

```
/
'
+- inventory/
'          '
'          '- hosts.yml               #? IPv4 of machines on which to run Ansible scripts
'          '
'          +- folder_with_variables/
'
+- roles/
       '
       +- rolename/
                 '
                 +- defaults/         #? Default values for variables
                 '
                 +- files/            #? Configurations and other files that is needed
                 '
                 +- handlers/         #? Handlers
                 '
                 +- library/          #? Modules, for example python ones
                 '
                 +- meta/             #? Metadata about author and dependencies
                 '
                 +- tasks/            #? Tasks to run. 'main.yaml' is the starting one.    <-- Start here
                 '
                 +- templates/        #? Templates for Jinja2
                 '
                 +- vars/             #? Values for variables
```









#                  Where to save them

`/roles/requirements.yaml`










##                 Where to find the one I need if it links to gitlab

`gitlab.domain.com:lorem/ipsum.git` becomes
`gitlab.domain.com/lorem/ipsum`