source ./infrastructure/bin/build_local.sh

kubectl apply -f infrastructure/k8s
kubectl wait --for=condition=Ready pods --all
