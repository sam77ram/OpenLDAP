#!/bin/bash

read -p "Are you sure? [y/n] > " -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# get ip address and add 'ip address' to 'dns name' mapping to hosts file
LOCAL_IP="${LOCAL_IP:-`ipconfig.exe | grep -im1 'IPv4 Address' | cut -d ':' -f2`}"
LOCAL_IP=$(echo $LOCAL_IP | xargs) 
echo ${LOCAL_IP}
INGRESS_HOSTNAME="ldap.server.hostname.com"
HOSTS_FILE=/c/Windows/System32/drivers/etc/hosts
if grep -q "${LOCAL_IP} $INGRESS_HOSTNAME" $HOSTS_FILE; 
then
	echo "ip address to dns name mapping already configured in hosts file..."
elif grep -q $INGRESS_HOSTNAME $HOSTS_FILE; then 
	sed -i "s/.* ${INGRESS_HOSTNAME}/${LOCAL_IP} ${INGRESS_HOSTNAME}/g" $HOSTS_FILE
else
    echo "$LOCAL_IP $INGRESS_HOSTNAME" >> $HOSTS_FILE
fi

# set the cluster context to 'docker-desktop
kubectl config use-context "docker-desktop"

# setup ingress
# if the ingress links are not available then refer to the below link for updated URL.
# Use the steps or the URL listed under the section 'Docker for Mac'
# Ingress setup link: https://kubernetes.github.io/ingress-nginx/deploy/
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-0.32.0/deploy/static/provider/cloud/deploy.yaml
# kubectl apply -f ingress.yml

# create application deployment and service
kubectl apply -f kubernetes-ldap-server.yml

# describe deployed service
kubectl describe service "ldap-server-service"