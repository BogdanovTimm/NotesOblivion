1. `ssh-keygen`
2. `ssh-copy-id %user_on_remote_pc%@%222.222.222.3%`
3. `cd /etc/sudoers.d` - go to this directory and check whether there exists a file.
4. Open a file or create a new one and add this:
```
%user_on_remote_pc% ALL=(ALL) NOPASSWD:ALL
```