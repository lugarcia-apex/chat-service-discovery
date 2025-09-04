#!/bin/bash
set -e

echo "Switching to main branch and pulling latest changes..."
git checkout main
git pull origin main

echo "Building project with Maven (skipping tests)..."
mvn -q -DskipTests=true spotless:apply clean package

echo "Configuring Docker to use Minikube's Docker daemon..."
eval $(minikube docker-env)

echo "Building Docker image 'chat-service-discovery:latest'..."
minikube image build -t chat-service-discovery:latest -f docker/Dockerfile .

echo "Creating/updating ConfigMap from env.properties..."
kubectl create configmap chat-service-discovery-config --from-env-file=env.properties --dry-run=client -o yaml | kubectl apply -f -

echo "Applying Kubernetes manifests..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "Restarting deployment to use new image..."
kubectl rollout restart deployment/chat-service-discovery

echo "Waiting for pods to be ready..."
kubectl wait --for=condition=available --timeout=120s deployment/chat-service-discovery

echo "Deployment updated successfully."
kubectl get pods -l app=chat-service-discovery
