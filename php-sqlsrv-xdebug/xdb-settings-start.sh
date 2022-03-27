#!/bin/bash

echo "zend_extension=xdebug.so" > /etc/php/7.3/mods-available/xdebug.ini

if [ -n "$XDEBUG_REMOTE_CONNECT_BACK" ]
then
  echo "xdebug.remote_connect_back=$XDEBUG_REMOTE_CONNECT_BACK" >> /etc/php/7.3/mods-available/xdebug.ini;
fi

if [ -n "$XDEBUG_REMOTE_ENABLE" ] 
then
  echo "xdebug.remote_enable=$XDEBUG_REMOTE_ENABLE" >> /etc/php/7.3/mods-available/xdebug.ini;  
fi

if [ -n "$XDEBUG_REMOTE_AUTOSTART" ]
then
  echo "xdebug.remote_autostart=$XDEBUG_REMOTE_AUTOSTART" >> /etc/php/7.3/mods-available/xdebug.ini;
fi

if [ -n "$XDEBUG_REMOTE_HOST" ]
then
  echo "xdebug.remote_host=$XDEBUG_REMOTE_HOST" >> /etc/php/7.3/mods-available/xdebug.ini;
fi

if [ -n "$XDEBUG_REMOTE_PORT" ]
then
  echo "xdebug.remote_port=$XDEBUG_REMOTE_PORT" >> /etc/php/7.3/mods-available/xdebug.ini;
fi

if [ -n "$XDEBUG_IDEKEY" ]
then
  echo "xdebug.idekey=$XDEBUG_IDEKEY" >> /etc/php/7.3/mods-available/xdebug.ini;
fi

echo "xdebug.remote_log=/var/log/xdebug.log" >> /etc/php/7.3/mods-available/xdebug.ini;

/usr/sbin/apache2ctl -D FOREGROUND