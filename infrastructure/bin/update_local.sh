source ./infrastructure/bin/build_local.sh

kubectl set image deployment/app app=django-in-docker-starter_app:$IMAGE_TAG
