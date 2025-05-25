#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=DE/L=Heilbronn/O=42/OU=student/CN=rchavez.42.fr"


cat << EOF > /etc/nginx/sites-available/default
server {
	listen 443 ssl;
	listen [::]:443 ssl;

	server_name www.rchavez.42.fr rchavez.42.fr;

	ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
	ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

	ssl_protocols TLSv1.2 TLSv1.3;

	index index.php;
	root /var/www/html;

	location ~ [^/]\.php(/|$) { 
		try_files \$uri =404;
		fastcgi_pass wordpress:9000;
		include fastcgi_params;
		fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
	}
}
EOF

cat << EOF > /var/www/html/index.php
	<?php
	// PHP code to include any necessary logic (optional)
	?>
	<!DOCTYPE html>
	<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<title>Inception Page - rchavez</title>

		<!-- Some basic styling -->
		<style>
			body {
				background: url('https://source.unsplash.com/1600x900/?space,stars,universe') no-repeat center center fixed;
				background-size: cover;
				font-family: 'Arial', sans-serif;
				color: #fff;
				text-align: center;
				margin: 0;
				padding: 0;
				display: flex;
				justify-content: center;
				align-items: center;
				height: 100vh;
				flex-direction: column;
			}

			h1 {
				font-size: 3rem;
				text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
				margin-bottom: 20px;
			}

			p {
				font-size: 1.5rem;
				margin-bottom: 30px;
				font-weight: 400;
			}

			.container {
				background-color: rgba(0, 0, 0, 0.5);
				padding: 40px;
				border-radius: 15px;
				box-shadow: 0 4px 6px rgba(0, 0, 0, 0.7);
			}

			.footer {
				position: fixed;
				bottom: 10px;
				font-size: 1rem;
				text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
			}

			.btn {
				padding: 15px 30px;
				background-color: #4CAF50;
				color: white;
				border: none;
				border-radius: 8px;
				cursor: pointer;
				font-size: 1.2rem;
				margin-top: 20px;
				transition: background-color 0.3s ease;
			}

			.btn:hover {
				background-color: #45a049;
			}
		</style>
	</head>
	<body>

	<div class="container">
		<h1>Welcome to my Inception Page!</h1>
		<p>Username: <strong>rchavez</strong></p>
		<p>Running on Docker in a VM.</p>
		<p><em>The page within a page...</em></p>

		<!-- Button to direct to WordPress -->
		<a href="https://rchavez.42.fr/wordpress">
			<button class="btn">Go to WordPress</button>
		</a>
	</div>

	<div class="footer">
		<p>&#169; 2025 | Created by rchavez. All rights reserved.</p>
	</div>

	</body>
	</html>
EOF

ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default