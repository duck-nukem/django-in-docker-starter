IMAGE_TAG=$(xxd -l4 -ps /dev/urandom)
eval $(minikube -p minikube docker-env)

docker-compose build
docker tag django-in-docker-starter_app django-in-docker-starter_app:$IMAGE_TAG
docker tag django-in-docker-starter_web django-in-docker-starter_web:$IMAGE_TAG
