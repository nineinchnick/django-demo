FROM python:2.7.11-wheezy
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY code/ /code/
ENV DJANGO_SETTINGS_MODULE=docker_demo.settings.local APP_PORT=3001
EXPOSE 8000
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["runserver"]
