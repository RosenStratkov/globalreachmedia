FROM php:8.2-cli

RUN docker-php-ext-install pdo pdo_mysql

COPY ./app /app
WORKDIR /app

CMD ["sh", "-c", "php -S 0.0.0.0:${PORT} -t /app"]
