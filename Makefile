# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rchavez <rchavez@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 17:01:32 by rchavez@stu       #+#    #+#              #
#    Updated: 2025/05/02 18:01:50 by rchavez          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRC = ./srcs/docker-compose.yml

up:
	mkdir -p ./srcs/Data/mysql
	docker-compose -f $(SRC) build --no-cache
	docker-compose -f $(SRC) up -d


clean:
	docker-compose -f $(SRC) down --volumes --remove-orphans
	docker volume rm srcs_mdb || true
	docker network rm inception || true
	rm -rf ./srcs/Data

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