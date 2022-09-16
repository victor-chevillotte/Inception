#!/bin/bash

	echo "Wordpress: Editing wp-config.php..."
	sed -i 's/$DOMAIN_NAME/'$DOMAIN_NAME'/' /conf/nginx.conf

exec "$@"