FROM composer:2.2.6 as build

WORKDIR /app

COPY ./composer.json ./
COPY ./composer.lock ./

RUN composer install



FROM php:8.1.2-alpine

WORKDIR /app/roadrunner-laravel

COPY --from=build ./ ./

COPY ./ ./

CMD ["php", "artisan", "octane:start"]
