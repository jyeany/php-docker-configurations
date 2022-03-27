FROM ubuntu:18.04

RUN apt update
RUN apt -y upgrade

ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Apache2 Server
RUN apt -y install apache2
RUN mkdir /var/www/site
ENV APACHE_LOG_DIR /var/log/apache2
ADD index.html /var/www/site/index.html
ADD phpinfo.php /var/www/site/phpinfo.php
ADD site.conf /etc/apache2/sites-enabled/000-default.conf

# Add PHP 7.3
RUN apt -y install software-properties-common \
    dirmngr \
    apt-transport-https \
    lsb-release \
    ca-certificates
RUN add-apt-repository ppa:ondrej/php
RUN apt update
RUN apt -y install php7.3 php7.3-dev php7.3-xml -y --allow-unauthenticated 

# Install SQL Server Drivers
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork
RUN a2enmod php7.3
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt update
RUN ACCEPT_EULA=Y apt-get install msodbcsql17
RUN ACCEPT_EULA=Y apt-get install mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN echo "extension=pdo_sqlsrv.so" >> /etc/php/7.3/apache2/conf.d/30-pdo_sqlsrv.ini
RUN echo "extension=sqlsrv.so" >> /etc/php/7.3/apache2/conf.d/20-sqlsrv.ini
RUN apt -y install unixodbc unixodbc-dev

# Install xdebug
RUN apt install php-xdebug

# Add bash script for specifying xdebug settings
COPY xdb-settings-start.sh /usr/local/bin/xdb-settings-start.sh
RUN chmod +x /usr/local/bin/xdb-settings-start.sh

# Start Apache2 Server
# CMD /usr/sbin/apache2ctl -D FOREGROUND
CMD /usr/local/bin/xdb-settings-start.sh
