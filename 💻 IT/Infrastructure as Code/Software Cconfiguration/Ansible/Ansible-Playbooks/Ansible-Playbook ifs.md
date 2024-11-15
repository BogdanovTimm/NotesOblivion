# What it is?

It is a way to do a conditional programming

# Code

## Skip if list is epty

```yaml
---
- name: xPLAY_1x
  tasks:
    - name: xTASK_1x
	    ansible.builtin.shell: ls -l
        register: xVARIABLEx
    - name: xTASK_2x
        xANSIBLE.MODULEx: xCOMMANDx
        when: {{ xVARIBLEx.stdout.split() }}          # Variant if you want to transform it into a list
```









## Include tasks from file if...

You have two options:
- `xPLAYx:tasks:include_tasks` - it works as expected:
    ```
    ---
    - name: xPLAY_1x
      tasks:
      - include_tasks: xFILE_WITH_TASKSx.yml
        when: xVARIABLEx is not defined
    ```
- `xPLAYx:tasks:import_tasks` - it will chick condition not only on import_tasks, but also in every task within a file (it is stupid):
    ```
    ---
    - name: xPLAY_1x
      tasks:
      - import_tasks: xFILE_WITH_TASKSx.yml
        when: xVARIABLEx is not defined
    ```