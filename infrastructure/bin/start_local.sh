# TODO: undo bashisms
function get_pod_name() {
    kubectl get pods --template '{{range .items}}{{.metadata.name}};{{end}}' --selector=io.kompose.service=$1
}

function remove_obsolete_pods() {
  IFS=';' read -ra ADDR <<< "$1"
  for i in "${ADDR[@]}"; do
    echo "Performing: kubectl delete pod ${i%%;}"
    kubectl delete pod ${i%%;} || echo "Failed to delete pod ${i%%;}. It may not exist."
  done
}

function get_instance_count() {
  echo $1 | tr -cd ';' | wc -c || 1
}

function check_service_readiness() {
  echo "Waiting for pods to be ready..."
  kubectl wait --for=condition=Ready pods --all
}

# TODO: Extract minikube specific code?

# Get into minikube environment, and build images
eval $(minikube -p minikube docker-env)
docker-compose build --parallel

kubectl apply -f infrastructure/k8s
check_service_readiness

# Save pod names that will become obsolete
APP_INSTANCES=$(get_pod_name app)
WEB_INSTANCES=$(get_pod_name web)

kubectl scale -f infrastructure/k8s/app-deployment.yaml --replicas=$(($(get_instance_count $APP_INSTANCES) * 2))
kubectl scale -f infrastructure/k8s/web-deployment.yaml --replicas=$(($(get_instance_count $WEB_INSTANCES) * 2))
check_service_readiness

# TODO: Disallow launching new instances while deleting
kubectl cordon minikube
remove_obsolete_pods $APP_INSTANCES
remove_obsolete_pods $WEB_INSTANCES

kubectl scale -f infrastructure/k8s/app-deployment.yaml --replicas=$(($(get_instance_count $APP_INSTANCES) * 1))
kubectl scale -f infrastructure/k8s/web-deployment.yaml --replicas=$(($(get_instance_count $WEB_INSTANCES) * 1))
kubectl uncordon minikube