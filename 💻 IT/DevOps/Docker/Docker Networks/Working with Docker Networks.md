# What it is?

It is a virtual network that allows you to connect multiple Docker-Containers.
All Docker-Containers without a `--network` specified are connected to a default Docker-Bridge-Network. It is dangerous, because they are not isolated from each other.

Types of Docker-Networks:
* `bridge`  - the default one. Typically defines an isolated network for multiple containers belonging to a common project.
* `host`    - no virtual Docker-Network, Container works like other applications on the host. You can't use `--publish` and alike with this type of Docker-Network
* `overlay` - connect multiple Docker-Daemons (Dcoker Engines) together. Good choice when you need Docker-Containers running on different hosts to communicate, or when multiple applications work together using SWARM-Services.
* `macvlan` - assign a MAC-Address to a Docker-Container that makes a Docker-Container to look like a PC on your network.
* `ipvlan`  - provide full control over boh IPv4 and IPv6 addressing. IPvlan is similar to Macvlan, but doesn't assign unique MAC-Addresses to Docker-Containers. Consider using IPvlan when there's a restriction on the number of MAC-Addresses that can be assigned to a Network-Interface or PC-Network-Port.
* `none`    - application can't use Internet









# Create

`docker network create -d xDOCKER_NETWORK_TYPEx xDOCKER_NETWORKx`









# Run Docker-Container with Docker-Network

`docker run --network=xDOCKER_NETWORKx -id --name=xDOCKER_CONTAINERx xDOCKER_IMAGEx`

`docker run --network container:=xDOCKER_CONTAINERx` - run new Docker-Container and connect it to an existing Docker-Network of existing Docker-Container









# Connect/Disconnect running Docker-Container to the Docker-Network

`docker network connect xDOCKER_NETWORKx xDOCKER_CONTAINERx`

`docker network disconnect xDOCKER_NETWORKx xDOCKER_CONTAINERx`









# Delete Docker-Network

`docker network rm xDOCKER_NETWORKx`








# Publishing ports

`docker run --publish 127.0.0.1:8080:80 xDOCKER_IMAGEx` - route 8080 port on the PC to the80 port within the Docker-Container, but allow access to it only from this host AND all other hosts on the same OSI-Level-2 segment (e.g. all PCs connected to the sane OSI-Level-2-Switch). Also, port-forwarding works in both ways: `ping localhost:80` within Docker-Container will actually `ping your.host.com:8080` on your host-machine!