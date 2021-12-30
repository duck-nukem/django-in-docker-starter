eval $(minikube -p minikube docker-env)
docker-compose build
kubectl apply -f infrastructure/k8s
