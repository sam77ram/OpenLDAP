# set the cluster context to 'docker-desktop
kubectl config use-context "docker-desktop"

# delete service
kubectl delete service "ldap-server-service"

# delete deployment
kubectl delete deployment "ldap-server-deployment"
