```YAML
all:
    vars:
       ansible_user: student
       ansible_ssh_private_key_file: "~/.shh/id_rsa"
    children:
       part1:
          hosts:
             10.0.10.112 # Ip of backend
       part2:
          hosts:
             10.0.10.112 # Ip of frontend
```