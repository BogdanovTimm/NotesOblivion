# Encrypt

Yes, you can encrypt your ansible Playbooks

`ansible-vault encrypt Playbookname.yaml` - encrypt Playbook

# Use encrypted file

`ansible-playbook Playbookname.yaml --ask-vault-pass` - ask for password
`ansible-playbook Playbookname.yaml --vault-password-file=file_with_password.txt` - ask for password

# Decrypt Playbook

`ansible-vault decrypt Playbookname.yaml`