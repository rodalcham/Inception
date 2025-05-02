# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rchavez <rchavez@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 17:01:32 by rchavez@stu       #+#    #+#              #
#    Updated: 2025/05/02 15:39:44 by rchavez          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRC = ./srcs/docker-compose.yml

up:
	docker-compose -f ${SRC} up -d

re:
	docker-compose -f ./srcs/docker-compose.yml down --volumes --remove-orphans
	rm -rf ./srcs/Data
	# mkdir -p ./Data/mysql
	docker-compose -f ./srcs/docker-compose.yml build --no-cache
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f $(SRC) down

stop:
	docker-compose -f $(SRC) stop

start:
	docker-compose -f $(SRC) start

status:
	docker ps

wait:
	@echo "Waiting for MySQL to be ready..."
	@docker exec -it mariadb bash -c 'until mysqladmin ping --silent; do echo "Waiting for MySQL..."; sleep 1; done'
	@echo "MySQL is ready!"