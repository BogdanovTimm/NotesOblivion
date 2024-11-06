# Installtion

We will have:
```
            [xSWARM_MANAGERx]
              /            \
[xSWARM_WORKER_2x]    [xSWARM_WORKER_1x]
```

1) Enshure that all 3 PCs have 2377, 7946 and 4789 ports opened.
2) Enshure that your SWARM-Manager PC has fixed IP-Address
3) Install Docker-Engine (simple docker) at all 3 PCs
4) Setting your SWARM-Manager PC:
    1) `docker swarm init --advertise-addr x100.100.100.100:55555x` - run this command on your SWARM-Manager PC
    2) `docker node update --availability drain xSWARM_MANAGERx` - run this command on your SWARM-Manager PC to restrict it from acting like SWARM-Worker (by default, SWARM-Managers sometimes act like SWARM-Workers). It does not remove standalone Docker-Containers that were run by `docker run` or `docker compose up`.
    3) `docker node inspect xSWARM_MANAGERx --format "{{ .ManagerStatus.Reachability }}"` - check that SWARM-Manager is working. 'reachable' means that.
    4) `docker swarm join-token worker` - run this command on your SWARM-Manager PC
5) `docker swarm join --token xLONG_TOKEN_FROM_PREVIOUS_STEPx x100.100.100.100:55555x` - run this on both of your SWARM-Worker PCs
6) `docker node ls` - run this command on your xSWARM_MANAGERx PC. It checks statuses of SWARM-Managers and SWQARM-Workers (empty 'MANAGER STATUS' column). If they are OK, then now you have working SWARM-Cluster!