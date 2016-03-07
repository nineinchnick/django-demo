FROM nginx:1.9.11
RUN mkdir /usr/share/nginx/html/static && mkdir /usr/share/nginx/html/media
COPY mysite.template /etc/nginx/conf.d/mysite.template
ENV NGINX_HOST=localhost APP_PORT=3001
CMD /bin/bash -c "envsubst < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
