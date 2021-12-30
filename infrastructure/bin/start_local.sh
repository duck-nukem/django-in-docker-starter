eval $(minikube -p minikube docker-env)
docker-compose build --parallel
kubectl delete -f infrastructure/k8s/app-deployment.yaml || true
kubectl delete -f infrastructure/k8s/web-deployment.yaml || true
kubectl apply -f infrastructure/k8s
