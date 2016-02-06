Django Demo
===========


```
docker build -t jwas/django-demo .
docker run --name=db -e POSTGRES_PASSWORD=postgres -d postgres
docker run -v /home/jwas/src/django-demo/code:/code --link=db -p 8000 --name=django-demo -d jwas/django-demo
docker exec -it django-demo python manage.py makemigrations
docker exec -it django-demo python manage.py sqlmigrate whoami 0001
```

todo:

* add entry, list previous entries
* add master/slave db config
* add nginx container

# SQL

```
BEGIN;
--
-- Create model Entry
--
CREATE TABLE "whoami_entry" ("id" serial NOT NULL PRIMARY KEY, "contents" text NOT NULL, "created_on" timestamp with time zone NOT NULL);

COMMIT;
```
