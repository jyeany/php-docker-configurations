FROM php:7.3.3-apache
RUN pecl install xdebug-2.7.0 \
    && docker-php-ext-enable xdebug \
    && mkdir /remote-log \
    && touch /remote-log/remote.log \
    && chmod a+w /remote-log/remote.log
        
COPY docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini     
COPY app/ /var/www/html