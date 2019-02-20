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

## Adjust the Configuration
Find your ip address using *ifconfig* or *ipconfig*  

Replace the ip address in *docker-php-ext-xdebug.ini* with your ip address
```
xdebug.remote_host=<your-ip-address-here>
``` 
  
Changes to the ini file require a stop/start to be reflected.
Changes to in the */app* directory sync automatically.  

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
        "/var/www/html": "${workspaceRoot}/app"    
    }
}
```