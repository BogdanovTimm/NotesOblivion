1. `vault auth enable approle`
2. Create a file for policy named `folder1.hcl` and add in it:
```
path "root_folder/*" {
    policy = "read"
}
```
3. `vault policy write new_policy1 /path/to/folder1.hcl`
4. `vault write auth/approle/role/new_role1 token_policies="new_policy1" token_ttl=1h token_max_ttl=4h`
5. `vault read auth/approle/role/new_roolt1`
6. `vault read auth/approle/role/new_role1/role-id` - get role_id
7. `vault write -force auth/approle/role/new_role1/secret-id` - create secret_id
8. Create Playbook.yaml:
```YAML
- hosts: hostname_from_hosts.init
  vars_prompt:
    - name: "given_secret_id"
      prompt: "Enter vault secret_id"
      private: yes 
  vars:
    vault1_address: https://vault1.server.ru:8201
    role_id: 108383ad-95f0-0c8e-b40f-186d383c53e8
    value1_from_vault: "{{ lookup('hashi_vault', 'secret=root_folder/data/folder1:value1 auth_method=approle role_id={{role_id}} secret_id={{given_secret_id}} url={{ vault1_address }}') }}"
  tasks:
    - name: Return all kv v2 secrets from a path
      debug:
        msg: "{{ value1_from_vault }}"
```