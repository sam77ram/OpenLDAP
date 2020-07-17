# Set project root dir to a variable to use later
export PROJECT_HOME_DIR = $(shell pwd)

IMAGE = ldap-server

# Make sure recipes are always executed
.PHONY: build push clean

# Build and tag Docker image
build:
	@echo "Building Docker Images ..."
	docker build -t ${IMAGE} .

# Push Docker image
push:
	@echo "Pushing Docker images ..."
	docker tag ${IMAGE} sumitramteke7/${IMAGE}
	docker push sumitramteke7/${IMAGE}

release: build push clean

# Clean up the created images locally and remove rvm gemset
clean:
	@echo "Cleaning Docker images ..."
	docker rmi -f ${IMAGE}

deploy: deploy-task

deploy-task:
	cd ${PROJECT_HOME_DIR} && ./deploy_local.sh

undeploy: undeploy-task

undeploy-task:
	cd ${PROJECT_HOME_DIR} && ./undeploy_local.sh	