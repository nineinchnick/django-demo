docker build -t jwas/django-demo .
docker run --name db -e POSTGRES_PASSWORD=postgres -d postgres
docker run -v /home/jwas/src/django-demo/code:/code --link db --name django-demo -d jwas/django-demo
