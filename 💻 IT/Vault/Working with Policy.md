#                  Create a new one

1. Create a file for policy named `folder1.hcl` and add in it:
```
path "root_folder/*" {
    policy = "read"
}
```
2. `vault policy write new_policy1 /path/to/folder1.hcl`
3. `vault policy list` - new_policy1 must be here
4. `vault token create -policy=new_policy1` - create a token with this policy
5. `vault list auth/token/accessors` - shows all tokens
6. `vault token lookup -accessor fiFMC6kVWa9DS2N1bCp58ff9`