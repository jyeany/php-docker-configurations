FROM jyeany/php-sqlsrv-xdebug:latest

RUN apt -y install curl php-cli php-mbstring git unzip
RUN a2enmod rewrite
RUN cd ~
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer global require "laravel/lumen-installer"