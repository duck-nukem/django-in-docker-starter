IMAGE_TAG=$(xxd -l4 -ps /dev/urandom)
eval $(minikube -p minikube docker-env)

docker-compose build --parallel
docker tag django-in-docker-starter_app django-in-docker-starter_app:$IMAGE_TAG
docker tag django-in-docker-starter_web django-in-docker-starter_web:$IMAGE_TAG

# Apply
kubectl apply -f infrastructure/k8s
kubectl wait --for=condition=Ready pods --all

# Update
kubectl set image deployment/app app=django-in-docker-starter_app:$IMAGE_TAG
kubectl set image deployment/web web=django-in-docker-starter_web:$IMAGE_TAG
