FROM composer:2.2.6 as build

WORKDIR /app

COPY ./composer.json ./
COPY ./composer.lock ./

RUN docker-php-ext-install sockets \
    bz2 \
    zip \
    intl \
    json \
    curl \
    dom \
    gd \
    libxml \
    mbstring \
    openssl \

RUN composer install



FROM php:8.1.2-alpine

WORKDIR /app/roadrunner-laravel

COPY --from=build ./ ./

COPY ./ ./

CMD ["php", "artisan", "octane:start"]
