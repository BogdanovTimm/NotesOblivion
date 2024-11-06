# What it is?

SWARM-Service is a desired state of some number of SWARM-Tasks (with 1 Docker-Container in each SWARM-Task)









# Deploy (aka create) new SWARM-Service

Run this code on your SWARM-Manager PC. It creates a new SWARM-Service with 5 replicas (actual number of simultaneously running containers) that will run Alpine-Linux Docker-Image and ping google.com:
```bash
docker service create          \
    --replicas 5               \ # Number of replicas
    --name xSWARM_SERVICEx     \ # Just SWARM-Service alias
    --update-delay 10s         \ # Number of time between simultaneously changin SWARM-Tasks [docker service update]
    --update-parallelism 1     \ # Max number of SWARM-Tasks you can simultaneously change using [docker service update]
    --publish "published=55555,\ # Route this port on each SWARM-Worker PC to...
target=44444,\                   #         ...this port within the Docker-Container. Also defines OSI-Level-4 protocol
protocol=udp,\                   # Protocol to use [udp] or [tcp]
mode=host"                       # Whether to use (ingress) or not (host) of Docker-Load-Balancer (Routing-Mesh)
    --endpoint-mode dnsr       \ # Set whether to use Docker-Virtual-IP-Addresses (vip) or default IP-Address of the PC
    alpine                     \ # Docker-Image to use. In this case it runs Alpine-Linux
        ping google.com          # Command for Docker-Image to use
```
You can't use `--endpoint-mode dnsrr` together with `--publish mode=ingress`









# Change existing SWARM-Service

`docker service scale xSWARM-SERVICEx=5` - run this code on your SWARM-Manager PC. It changes number of replicas (active containers) to 5

`docker service update --image xNEW_IMAGEx xSWARM_SERVICEx` - run this code on your SWARM-Manager PC. It changes Docker-Image that your SWARM-Service uses

1) `docker service update --publish-add published=55555,target=44444,protocol=tcp,mode=host xSWARM_SERVICEx` - change or add routing between the port on the SWARM-WORKER, that runs the container (55555) and the port within the Docker-Container (44444). So, each HTTP-Query to SWARM_WORKER:55555 will be routed to the Docker-Container:44444. 'protocol' allows you to choose which OSI-Level-4 protocol to use. 'mode' allows you to choose between:
   * `host` - mode in which there is no Routing-Mesh - built-in Docker Load-Balancer. It means that:
       * If current PC runs 2 same SWARM-Tasks (2 identical Docker-Containers) AND you use static ports - then only 1 of them can listen on a port
       * If current PC does not run the Docker-Container that you need - then nothing happens.
    * `ingress` - mode in which there is a Routing-Mesh - built-in Docker Load-Balancer. It means that:
       * If current PC runs 2 same SWARM-Tasks (2 identical Docker-Containers) - then Routing-Mesh will route your HTTP-Request to either of 2 Docker-Containers
       * If current PC does not run the Docker-Container that you need - then it will route your HTTP-Request to the SWARM-Worker that has it.
2) `docker service inspect --format="{{json .Endpoint.Spec.Ports}}" xSWARM_SERVICEx` - check which ports are routed.











# Delete existing SWARM-Service

1) `docker service rm xSERVICE_NAMEx` - run this code on your SWARM-Manager PC. It deletes existing SWARM-Service
2) `docker service inspect xSERVICE_NAMEx` - check that SWARM-Service was deleted





# Display SWARM-Service statuses

`docker service ps xSERVICE_NAMEx` - Display SWARM-Service and their statuses