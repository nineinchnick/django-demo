Django Demo
===========


Run:

```
docker build -t jwas/django-demo .
docker build -t jwas/django-db db
docker run --name=db -e POSTGRES_PASSWORD=postgres -d jwas/django-db
docker run -v /home/jwas/src/django-demo/code:/code --link=db -p 8000:8000 --name=django-demo -d jwas/django-demo
```

Service:

```
docker exec -it django-demo python manage.py makemigrations
docker exec -it django-demo python manage.py sqlmigrate whoami 0001
```

# SQL

```
BEGIN;
--
-- Create model Entry
--
CREATE TABLE "whoami_entry" ("id" serial NOT NULL PRIMARY KEY, "contents" text NOT NULL, "created_on" timestamp with time zone NOT NULL);

COMMIT;
```

```
docker run -it --link db --rm postgres sh -c 'exec psql -h db -U postgres'
```
