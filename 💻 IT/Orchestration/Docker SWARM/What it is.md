# What it is?

SWARM is an orchestrator for Docker-Containers. SWARM runs **SWARM-services** - number of **SWARM-Tasks** with predefined:
* Docker-Container (only 1 Docker-Container per **SWARM-Task**)
* CPU and RAM limits - if you have a task that requires 500 GB of RAM and there is no SWARM-Worker with such amount of RAM - then this SWARM-Task will be in the pending state untill such SWARM-Worker will be here.
* Number of replicas
* Ports

Types of SWARM-Service:
* Global SWARM-Service - will be run on each SWARM-Manager and each SWARM-Worker
* Replicated SWARM-Service - will be run on pre-defined number of SWARM-Wrokers









# How it works?

SWARM uses 2 types of applicaitons to work:
* SWARM-Manager - functions:
    * API-Endpoint
    * Runs SWARM-Workers
    * Every SWARM-Manager by default is SWARM-Worker. To disable it, use `docker node update --availability drain xNODE_NAMEx`. If there is no SWARM-Workers and every SWARM-Manager has **--availability=drain** - then new tasks will be in **pending** state.
    * Be turned into SWARM-Worker by `docker node demote xNODE_NAMEx`. 
* SWARM-Worker - functions (You can't create a SWARM-Worker without SWARM-Manager):
    * Runs Docker-Containers
    * Be turned into SWARM-Manager by `docker node promote xNODE_NAMEx`