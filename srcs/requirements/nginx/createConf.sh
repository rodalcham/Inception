#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=DE/L=Heilbronn/O=42/OU=student/CN=rchavez.42.fr"


cat << EOF > /etc/nginx/sites-available/default
server {
	listen 443 ssl http2;
	listen [::]:443 ssl http2;

	server_name www.rchavez.42.fr rchavez.42.fr;

	ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
	ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

	ssl_protocols TLSv1.2 TLSv1.3;

	index wp-login.php;
	root /var/www/html;

	location ~ [^/]\.php(/|$) { 
		try_files \$uri =404;
		fastcgi_pass wordpress:9000;
		include fastcgi_params;
		fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
	}
}

ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default