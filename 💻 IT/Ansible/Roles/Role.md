# What it is?

Roles is a little parts of a Playbookname.yaml. Different from [[Import tasks]], roles have their structure with variables, hendlers, etc.








# Creating a new one
1. `mkdir roles && cd roles` - creating a `roles` folder
2. `ansible-galaxy init new_role_name`









#                  Structure of role repository

```
./defaults/  - default values for variables
./files/     - configurations and other files that is needed
./handlers/  - handlers
./library/   - modules, for example python ones
./meta/      - metadata about author and dependencies
./tasks/     - tasks to run. 'main.yaml' is the starting one.
./templates/ - templates for Jinja2
./vars/      - values for variables
```









#                  Where to save them

`/roles/requirements.yaml`










##                 Where to find the one I need if it links to gitlab

`gitlab.domain.com:lorem/ipsum.git` becomes
`gitlab.domain.com/lorem/ipsum`