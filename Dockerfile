FROM postgres:17.5-alpine3.22

COPY ./main.sql ./docker-entrypoint-initdb.d/main.sql