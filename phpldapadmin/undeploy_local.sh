# set the cluster context to 'docker-desktop
kubectl config use-context "docker-desktop"

# delete service
kubectl delete service "phpldapadmin-service"

# delete deployment
kubectl delete deployment "phpldapadmin-deployment"