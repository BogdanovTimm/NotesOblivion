# What it is?

It is a way to store and use passwords, etc


# Crate a SWARM-Secret

`printf "This is a secret" | docker secret create xSWARM_SECRETx -`









# Allow/Disallow SWARM-Service to use an existing SWARM-Secret

`docker service create --secret source=xSWARM_SECRETx xDOCKER_IMAGEx` - copy existing SWARM-Secret into the /run/secret/xSWARM_SECRETx file within the container
`docker service create --secret source=xSWARM_SECRETx,target=/path/in/container/to/secret.txt xDOCKER_IMAGEx` - copy existing SWARM-Secret into the file with custom path within the container

`docker service update --secret-rm xSWARM_SECRETx xSWARM_SERVICEx` - remove secret from the SWARm-Service







# Display SWARM-Secret that given SWARM-Service uses

1) `docker container exec $(docker ps --filter name=xSWARM_SERVICEx -q) ls -l /run/secrets` - displays name of the SWARM-Secrets
2) `docker container exec $(docker ps --filter name=redis -q) cat /run/secrets/xSWARM_SECRETx` - display the content of the SWARM-Secret









# Display all SWARM-Secrets available on the PC

`docker secret ls`