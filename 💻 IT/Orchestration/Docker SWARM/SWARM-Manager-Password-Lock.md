# What it is?

When SWARM-Manager restarts, both the TLS key used to encrypt communication among SWARM-Managers and SWARM-Workers nodes, and the key used to encrypt and decrypt Raft logs on disk, are loaded into each SWARM-Manager node’s memory.









# Commands

`docker swarm init --autolock` - transform current Docker-Engine into the SWARM-Manager and ebable SWARM-Password-Lock
`docker swarm unlock-key --rotate` - update password. If the key was rotated after one of the SWARM-Manager nodes became unavailable and if you don’t have access to the previous key you need to force the SWARM-Manager to leave the SWARM-Cluster and join it back as a new WARM-Manager!
 `docker swarm unlock` - you need to run it every time after the restart of the SWARM-Manager

`docker swarm unlock-key` - display current SWARM-Password-Lock

 `docker swarm update --autolock=true`  - enable SWARM-Password-Lock on the running SWARM-Manager
 `docker swarm update --autolock=false` - disable SWARM-Password-Lock on the running SWARM-Manager