# What is is?

Ansible-Inventory is a set of sets of hosts.
It may be written either in:
* .ini
* .yaml

Each host will be in at least 2 Ansible-Inventory-Groups:
* all
* ungrouped









# Why?

Because you may have 2 groups of hosts: test and prod. Then, you can create only 1 Ansible-Playbook and use the same commands to both test and prod hosts in different times.









# Groups of groups of hosts

Some terminology:
* Bigger group - Ansible-Inventory-Group-Parent that contains Ansible-Inventory-Group-Children
* Smaller group - Ansible-Inventory-Group-Children that is placed within Ansible-Inventory-Group-Parent

1 host may be added to different Ansible-Groups, including Ansible-Groups of the same level.









## Group:vars

You may set same Ansible-Inventory-Host-Variables for all hosts in some Ansible-Inventory-Group.
But remember that if your host is in more than 1 Ansible-Inventory-Group, Ansible will use Ansible-Inventory-Variables from all Ansible-Inventory-Groups that this host consists in. If different Ansible-Inventory-Groups of the same level are define same Ansible-Inbentory-Host-Variable, than Ansible will choose which one of values to use using:
* Order of different inventories, given via `ansible -i xINVENTORY1x.yaml -i xINVENTORY2x.yaml  `
* `xGROUP_1x:vars:ansible_group_priority` - it is a special Ansible-Inventory-Group-Shared_Variable tha defines the priority of its Ansible-Inventory-Host-Variables. It can be set only in the base Ansible-Inventory-File. The default value for this is 1. The higher ones will rewrite the lower ones.
* Names of the files - `x.yaml` will rewrite `a.yaml` (yes, it is very stupid)
* Place of the Ansible-Inventory-Host-Variables in the single file: first Ansible-Inventory-Host-Variable (the upper one) will override the next ones (the lower ones)

You can define Ansible-Inventory-Group-Shared_Variables and Ansible-Inventory-Host-Variables within the 1 file, but it is more convenient to place them like:
```
/xPATH/TO/PLAYBOOKx/group_vars/xGROUP_1_TO_WHICH_HOST_1_BELONGSx/
/xPATH/TO/PLAYBOOKx/group_vars/xGROUP_2_TO_WHICH_HOST_1_BELONGSx/
/xPATH/TO/PLAYBOOKx/host_vars/xHOST_1x/
```








# Where you can find it

Remember that if you have your Ansible-Inventory-Group-Parent and Ansible-Inventory-Group-Children groups in separate files, you need to make that the Ansible-Inventory-Group-Children always loads before their Ansible-Inventory-Group-Parents. So, you need to add prefixes to the filenames so you have something like:
* `01-xINVENTORY_WITH_CHILDRENSx.yaml`
* `02-xINVENTORY_WITH_PARENTSx.yaml`

Where Ansible will find Ansible-Inventories:
* `/etc/ansible/hosts` - Default Ansible-Inventory file
* `/etc/ansible/hosts/group_vars/xGROUP_1x` - Default Ansible-Inventory-Group-Shared_Vars
* `/etc/ansible/hosts/host_vars/xHOST_1x` - Default Ansible-Inventory-Host-Vars
* `ansible -i /xPATH/TO/INVENTORY/INVENTORYx.yaml`
* `ansible -i /xPATH/TO/INVENTORYx`
* `ansible --playbook-dir /xPATH/TO/PLAYBOOKx`
* `ansible.cfg` - you can define your inventory directory here









# Patterns

You may further strict the hosts from Inventory-File using Ansible-Inventory-Pattern:
* `ansible xHOSTx -m xMODULEx -a xMODULE_OPTIONSx`
* Within a Playbook.yaml:
    ```yaml
    - name: xPLAYx
      hosts: xHOSTx
    ```

Remember that only hostst that are already defined in the Ansible-Inventory file can be used.

Also, there is a special syntax for Ansible-Inventory-Patterns:
- `all` or `*` - All hosts
- `127.*` - all IP-Addresses that start with 127
- `xHOST_x*` - all hostst that start with xHOST_x
- `xHOST_1x:xHOST_2x` or `xHOST_1x,xHOST_2x` - Multiple hosts	
- `xGROUP_1x:!xGROUP_2x` - all hosts in xGROUP_1x except those that are also in xGROUP_2x
- `xGROUP_1x:&xGROUP_2x` - hosts that are in both xGROUP_1x and xGROUP_2x