# K8S

## Caveats

- Currently it's only configured for local development/deployment.
- Images aren't pulled, they are built from the local Dockerfiles.
- An **INSECURE** metrics-server is used. It's __PROBABLY__ fine, because it's only internal, but I'd still recommend finding another way to monitor metrics. 

An example of how to make the images available for k8s is:
```bash
IMAGE_TAG=$(xxd -l4 -ps /dev/urandom) # could also be the git commit hash

docker-compose build
docker tag django-in-docker-starter_app django-in-docker-starter_app:$IMAGE_TAG
docker tag django-in-docker-starter_web django-in-docker-starter_web:$IMAGE_TAG
```

if you're using minikube you can use the following command to push the images to the registry:
```bash
eval $(minikube -p minikube docker-env)
```


## Deployment

```bash
# from project root
kubectl apply -f infrastructure/k8s
kubectl wait --for=condition=Ready pods --all
```

## Update

```bash
# from project root
kubectl set image deployment/app app=django-in-docker-starter_app:$IMAGE_TAG
```

#### Where

* `deployment/app` is the name of the deployment defined in one of the yaml files in infrastructure/k8s
* `app=` is the service name
* `django-in-docker-starter_app:$IMAGE_TAG` is the docker image name and tag

## Delete

```bash
# from project root
kubectl delete -f infrastructure/k8s
```

This will deploy the infrastructure to a local node.
