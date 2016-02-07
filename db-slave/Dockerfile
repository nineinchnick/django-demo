FROM postgres:latest
COPY slave-entrypoint.sh /
ENV MASTER_HOST=db MASTER_PORT=5432
ENTRYPOINT ["/slave-entrypoint.sh"]
CMD postgres
