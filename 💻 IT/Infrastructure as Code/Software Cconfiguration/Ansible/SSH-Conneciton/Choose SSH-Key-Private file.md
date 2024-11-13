# How to choose different SSH-Key-Private?

You may either:
- Add something like this into your Ansible-Inventory file.init:
    ```init
    xSERVER_1.DOMAINx.com ansible_ssh_private_key_file=/xPATH/TO/PRIVATEx
    ```
- Add something like this into your Ansible-Inventory file.yaml:
    ```init
    xSERVER_1.DOMAINx.com:
      ansible_ssh_private_key_file: /xPATH/TO/PRIVATEx
    ```
- `ansible --private-key=/xPATH/TO/PRIVATEx` - Use special flag during running Ansible-Playbook: