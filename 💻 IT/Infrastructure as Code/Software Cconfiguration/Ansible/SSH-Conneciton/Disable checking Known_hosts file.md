# What it is?

If remote host changed its SSH-Keys, trying to SSH to it will lead to the error.
If remote host is not in the Known_hosts file, trying to SSH to it will lead to the promt.

# How to disable it?

To disable it you may etither:
- `vim /etc/ansible/ansible.cfg` and change it to contain:
    ```
    [default]
    host_key_checking = False
    ```
- `export ANSIBLE_HOST_KEY_CHECKING=False` - rewrite Linux-Environment-Variable