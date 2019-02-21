FROM php:7.2.15-apache
RUN pecl install xdebug-2.6.1 \
    && docker-php-ext-enable xdebug \
    && mkdir /remote-log \
    && touch /remote-log/remote.log \
    && chmod a+w /remote-log/remote.log

RUN a2enmod rewrite
        
COPY docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 

RUN apt update

RUN apt-get install -y libpq-dev

RUN docker-php-ext-install pdo pdo_pgsql

RUN apt install -y curl git unzip

RUN cd ~

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN composer global require "laravel/lumen-installer"

COPY apache2.conf /etc/apache2/apache2.conf