# Docker Configuration for Lumen Development

## Overview
Docker container with apache 2 server configured with xdebug to provide a quick start and consistent environment for Lumen
framework development. Files created for the Lumen application will by synced with the */app* folder.

## Running the Containers
Start containers with:
```
docker-compose up -d
```

Stop containers with:
```
docker-compose stop
```
  
To start and rebuild after adjusting configuration:
```
docker-compose build
```

## Create the Lumen Application
Open shell to docker container
```
docker exec -it lumen /bin/bash
```
  
Create the application
```
composer create-project --prefer-dist laravel/lumen my-app
```

## Make sure lumen is running

Visit:
```
http://localhost/my-app/public/
```

Expected output:
```
Lumen (6.2.0) (Laravel Components ^6.0)
```

## Setup the database connection params

Update the *.env* file in application root. Example:
```
APP_NAME=Lumen
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost
APP_TIMEZONE=UTC

LOG_CHANNEL=stack
LOG_SLACK_WEBHOOK_URL=

DB_CONNECTION=pgsql
DB_HOST=lumen-postgres
DB_PORT=5432
DB_DATABASE=<db-name-here>
DB_USERNAME=<db-user-here>
DB_PASSWORD=<db-user-password>

CACHE_DRIVER=file
QUEUE_CONNECTION=sync
```
  
In *<app-root>/app.php* uncomment:
```
$app->withFacades();
```

## Adjust the Configuration
Find your ip address using *ifconfig* or *ipconfig*  

Replace the ip address in *docker-php-ext-xdebug.ini* with your ip address
```
xdebug.remote_host=<your-ip-address-here>
``` 
  
Changes to the ini file require a stop/start to be reflected.
Changes to in the */src* directory sync automatically.  

#### Apache2 Configurations
Changes specific to the application for the apache2 web server can be made in the .htaccess file generated in the */public* folder.
Changes to the overall server configuration can be made in the *apache2.conf* file.

## VS Code Debug Settings

Using the PHP Debug extension:
https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug  

```
{
    "name": "Listen for XDebug",
    "type": "php",
    "request": "launch",
    "port": 9000,    
    "pathMappings": {
        "/var/www/html": "${workspaceRoot}/src"    
    }
}
```

## Unit test execution
  
The *phpunit* executable is not added to the path automatically by the *composer create-project* command.  
In order to have it accessible without adding its path within the project, */vendor/bin/phpunit*, use the following:
```
ln -s /var/www/html/<your-app-name>/vendor/bin/phpunit /usr/local/bin/phpunit
```

Unit tests can be debugged using the same launch.json as the application, just run *phpunit* and place a breakpoint.