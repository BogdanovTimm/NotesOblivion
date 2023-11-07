Cluster:
- Service - entry point via ClusterIP, NodePort, LoadBalancer, ExternalName
- Deployment - do autoscaling, updating, pre-defined minimal amount of pods
- Master Server (Node)
- Worker Servers (Nodes):
	- 1 Pod - it is something like docker.compose:
		- 1 Docker-Image