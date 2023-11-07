# Warning

Nobody runs pods themselves - they need to be runned via deploys

# Creating a new one

1. Open docker
2.  `minikube start -p clusterName --cpus=4 --memory=8gb --disk-size=5gb` - creating of a cluster
3. Create customPod.yaml file
4. `kubectl apply -f customPod.yaml`
5. `kubectl port-forward customPod 8888:80` - where 8888 is port which you need to write in browser and second one is port that is opened in customPod.yaml

# Get logs

`kubectl logs podname`

# Go inside pod

`kubectl exec -it podName bash`

# Updating

You can simply change `spec:containers:image:` image and do another `kubectl apply -f customPod.yaml` to update this pod

# Get all pods

`kubectl get pods`

# Get information about pod

`kubectl describe pods customPod`

# Delete Pod

`kubectl delete -f customPod.yaml`