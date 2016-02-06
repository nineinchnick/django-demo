FROM python:2.7
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD code/ /code/
ENV DJANGO_SETTINGS_MODULE=docker_demo.settings.local
EXPOSE 8000
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
CMD runserver
