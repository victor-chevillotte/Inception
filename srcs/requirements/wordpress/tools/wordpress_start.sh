#!/bin/bash
	echo "php: setting up..."
	sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
	chown -R www-data:www-data /var/www/*;
	chown -R 755 /var/www/*;
	mkdir -p /run/php/;
	touch /run/php/php7.3-fpm.pid;
	echo "php: is set up!"

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Wordpress: setting up..."
	echo "Wordpress: Downloading command line interface..."
	mkdir -p /var/www/html
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;
	echo "Wordpress: Downloading wordpress file..."
	cd /var/www/html;
	wp core download --allow-root;
	echo "Wordpress: Setup database connection..."
	echo "Wordpress: Editing wp-config.php..."
	sed -i 's/$WP_DATABASE_NAME/'$WP_DATABASE_NAME'/' /var/www/wp-config.php
	sed -i 's/$WP_DATABASE_USR/'$WP_DATABASE_USR'/' /var/www/wp-config.php
	sed -i 's/$WP_DATABASE_PWD/'$WP_DATABASE_PWD'/' /var/www/wp-config.php
	sed -i 's/$MYSQL_HOST/'$MYSQL_HOST'/' /var/www/wp-config.php
	sed -i 's/$DOMAIN_NAME/'$DOMAIN_NAME'/' /var/www/wp-config.php

	echo "Wordpress: creating users..."
	wp core install --allow-root --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USR} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL}
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD};
	echo "Wordpress: is set up!"
fi

exec "$@"