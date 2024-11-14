# What it is?

Ansible-Ad-Hoc is a way to run some commands on the pre-defined Ansible-Inventory-Hosts and Ansible-Inventory-Groups









# Code

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m xANSIBLE_MODULEx -a "xCOMMANDx -f x10x -u xLINUX_USERx --become --ask-become-pass --check"`where:
* `-m xANSIBLE_MODULEx` - allows you to use some Ansible-Module. For example, Linux-Bash-Pipes will work only if you use module `asible.builtin.shell`
* `-a "xCOMMANDx"` - is a command to execute, for example `/sbin/reboot` to reboot all servers
* `-f x10x` - number of CPU-Parallel-Threads
* `-u xLINUX_USERx` - because Ansible works via SSH, you need to login as some existing on remote host Linux-User
* `--become --ask-become-pass` - same as use `sudo`. `--ask-become-pass` gives you promt to write Linu-User-Password
* `--check` - will check if given command can be executed, but wiull not actually execute it









# `ansible-console`

Also, you may use Ansible-Shell









## Linux-Environment_Variables that Ansible uses

Linux-Environment_Variables that Ansible uses:
* `ANSIBLE_INVENTORY=/etc/ansible/hosts` - default Ansible-Inventory file
* `ANSIBLE_LIBRARY` - default Ansible-Module library path
* `ANSIBLE_CONFIG=/etc/ansible/ansible.cfg` - default Ansible-Config file
* ... many more ooptions from `ansible.cfg`









## Examples

### Files

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.copy -a "src=/xPATH/ON/THIS/PCx dest=/xPATH/ON/REMOTE/PCx"` - copy file from this PC to all remote ones

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.file -a "dest=/xPATH/ON/REMOTE/PC/TO/FILE.TXTx mode=600 owner=xLINUX_USERx group=xLINUX_GROUPx"` - change Linux-File-Permissions and Linux-File-Owner-User and Linux-File-Owner-Group on the remote PC

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.file -a "dest=/xPATH/ON/REMOTE/PC/TO/NEW/FOLDERx mode=755 owner=xLINUX_USERx group=xLINUX_GROUPx state=directory"` - create new folder on remote PC

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.file -a "dest=/xPATH/ON/REMOTE/PC/TO/EXISTING/FOLDER/OR/FILE.TXTx state=absent"` - delete folder or file on remote PC









### Linux-Packages

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.yum -a "name=xPACKAGEx state=present"` - install new Linux-Package

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.yum -a "name=xPACKAGEx-x1.5x state=present"` - update to or install Linux-Package of given version

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.yum -a "name=xPACKAGEx state=absent"`- delete Linux-Package









### Linux-Services

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.service -a "name=xSERVICEx state=started"`- start Linux-Service

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.service -a "name=xSERVICEx state=restarted"`- restart Linux-Service

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.service -a "name=xSERVICEx state=stopped"`- stop Linux-Service









### Linux-Users

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.user -a "name=xLINUX_USERx password=xENCRYPTED_PASSWORDx"`- create a new Linux-User

`ansible xHOST_OR_GROUP_FROM_INVENTORYx -m ansible.builtin.user -a "name=xLINUX_USERx state=absent"`- delete Linux-User