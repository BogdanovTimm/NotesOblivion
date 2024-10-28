# What it is?

It is the best wat to connects to servers.
# Install

1. Create deploymentAutoscalerService.yaml
2. Run `kubectl apply -f .\deploymentAutoscalerService.yaml`

## Linux

3. `kubectl get services`
4. Safe CLUSTER-IP of custom-service - it is needed for accessing your website

## Windows

3. `kubectl expose deployment custom-deployment-with-autoscaler --type=NodePort --port 80`
4. `kubectl describe nodes`

# Get all services

`kubectl get svc`

# Delete everything

`kubectl delete -f .\deploymentAutoscalerService.yaml`