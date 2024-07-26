FROM mariadb:10.5.22

ENV MYSQL_ROOT_PASSWORD=database4OS \
    MYSQL_USER=admin \
    MYSQL_PASSWORD=passwd

COPY  ./init /docker-entrypoint-initdb.d

EXPOSE 3306

CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_unicode_ci", "--wait_timeout=28800", "--log-warnings=0"]

