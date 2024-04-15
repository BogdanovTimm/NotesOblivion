1. Download it from https://hashicorp-releases.yandexcloud.net
2. `sudo apt install -y unzip` - install tool for working with archives
3. `unzip vault_1.15.2_linux_amd64.zip`
4. `sudo mv vault /usr/local/bin`
5. Create a file `vault.hcl` and write in it:
```
storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address = "0.0.0.0:8201"
  tls_disable = 1
}

api_addr = "http://127.0.0.1:8201"
ui = true
disable_mlock = true
```
6. `VAULT_API_ADDR=http://127.0.0.1:8201 VAULT_API_SKIP_VERIFY=true vault server -config /path/to/vault.hcl`
7. `export VAULT_ADDR=http://127.0.0.1:8201` - for client
8. `export VAULT_SKIP_VERIFY=true` - for client
9. `vault status` - check that it works
10. `vault operator init` - create a vault
11. `vault operator init -key-shares=3 -key-threshold=2` - -key-share - how many keys to create. -key-threshold - how many of them need to open the vault. This command will give you Unseal keys and Initial Root Key. They will need to later, so safe them
12. `vault operator unseal` - and then you need to add 1st Unseal key. Repeat this step -key-threshold times
13. `vault login` - now you need to use Initial Root Key
14. `vault secrets enable -version=2 -path=root_folder1 kv` - enable Key-Values storage in folder1
15. `vault kv put -mount=root_folder1 folder2 value1=variable1` - saves value1=variable1 in root_folder1/data/folder2 (yes, it sucks...)
16. `vault kv get -version=1 root_folder1/folder2`