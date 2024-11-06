# How to activate it?

When you create a SWARM-Cluster, it automatically create a new ROOT-Certificate-Authority.


# Show current Certificate

`docker swarm ca`








# How to re-create a TLS-Certificates?

Types of new certificates:
* `docker swarm ca --rotate` - automatically create new Root-CA
* `docker swarm ca --rotate --ca-cert /path/to/root/public --ca-key /path/to/root/private` - use new certificates