FROM atlassian/default-image:4
FROM php:8.4-fpm
LABEL maintainer="David Cumberland <hi@davecodes.au>"

# Install required libraries and binaries
RUN apt update -y && \
    apt install -y libxml2-dev zlib1g-dev libpng-dev libmcrypt-dev libzip-dev libxslt-dev libcurl4-openssl-dev libssl-dev libicu-dev

# Install composer from container
COPY --from=composer:lts /usr/bin/composer /usr/local/bin/composer

# Install required Modules
RUN yes '' | pecl install -f mcrypt
RUN yes '' | pecl install -f redis
RUN docker-php-ext-install gd && docker-php-ext-enable gd
RUN docker-php-ext-install bcmath && docker-php-ext-enable bcmath
RUN docker-php-ext-install calendar && docker-php-ext-enable calendar
RUN docker-php-ext-install exif && docker-php-ext-enable exif
RUN docker-php-ext-install intl && docker-php-ext-enable intl
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install opcache && docker-php-ext-enable opcache
RUN docker-php-ext-install zip && docker-php-ext-enable zip
RUN docker-php-ext-install xsl && docker-php-ext-enable xsl
RUN docker-php-ext-install soap && docker-php-ext-enable soap
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql
RUN docker-php-ext-enable redis exif mcrypt bcmath calendar gd intl mysqli opcache pdo_mysql soap xsl zip
RUN pecl install raphf && docker-php-ext-enable raphf
RUN pecl install pecl_http && docker-php-ext-enable http

# Laravel Horizon
RUN docker-php-ext-configure pcntl --enable-pcntl \
  && docker-php-ext-install pcntl

# Laravel Vapor
RUN composer global require laravel/vapor-cli --update-with-dependencies

# NPM test
RUN apt install npm -y
RUN npm -v
