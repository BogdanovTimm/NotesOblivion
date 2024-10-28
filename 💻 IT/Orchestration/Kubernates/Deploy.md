# Creating a new one

## Bad way

1.  `kubectl create deployment customDeploymentName --image yourAccountName/serverName:latest`
2.  `kubectl scale deployment customDeploymentName --replicas 4`  
    OR  
    `kubectl autoscale deployment customDeploymentName --min=4 --max=6 --cpu-percent=80`

## Good way

1. Create `customDeploymentName.yaml`
2. `kubectl apply -f customDeploymentName.yaml`
3. `kubectl get pods`
4. Safe NAME of a pod you want to open ports to
5. `kubectl port-forward customPodName 8888:80`

# Get all deploys

`kubectl get deploy`

# Get all auto-scalers

`kubectl get hpa`

# Get information about deployment

`kubectl describe deployment customDeploymentName`

# Update deploy (change docker-container)

## If it is a concrete version

1.  `kubectl descrive deoployment customDeploymentName`
2.  Get first line after Containers (docker-container name)
3.  `kubectl set image deployment/customDeploymentName dockerContainerName=yourAccountName/serverName:version`

## If it is new latest version

1.  `kubectl rollout restart deoployment/customDeploymentName`

## Rollback to previous version

1.  `kubectl rollout history deployment/customDeploymentName`
2.  You need to save REVISION number
3.  `kubectl rollout undo deployment/customDeploymentname --to-revision=4` where 4 is REVISION number

# Delete

## Delete some

`kubectl delete deployment customDeploymentName`

## Delete all

`kubectl delete deployment --all`