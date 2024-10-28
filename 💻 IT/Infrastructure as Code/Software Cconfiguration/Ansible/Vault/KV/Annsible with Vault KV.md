1. `pip install hvac` or `sudo apt-get -y install python3-hvac`
2. Create a playbook:
```YAML
- hosts: hostname_from_hosts.init
  vars_prompt:
    - name: "given_vault_token"
      prompt: "Enter Init Root Token or Token with Policy"
      private: yes 
  vars:
    vault1_address: https://vault1.server.ru:8201
    value1_from_vault: "{{ lookup('hashi_vault', 'secret=root_folder/data/folder1:value1 token={{ given_vault_token }} url={{ vault1_address }}') }}"
  tasks:
    - name: Display variable1 from Vault
      debug:
        msg: "{{ value1_from_vault }}"
```