# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rchavez <rchavez@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 17:01:32 by rchavez@stu       #+#    #+#              #
#    Updated: 2025/05/25 19:11:21 by rchavez          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRC = ./srcs/docker-compose.yml

all:
	docker-compose -f $(SRC) up -d
up:
	mkdir -p /home/rchavez/data
	chmod 755 /home/rchavez/data
	mkdir -p /home/rchavez/data/mysql
	chmod 755 /home/rchavez/data/mysql
	mkdir -p /home/rchavez/data/wordpress
	chmod 755 /home/rchavez/data/wordpress
	sleep 1
	docker-compose -f $(SRC) build --no-cache
	docker-compose -f $(SRC) up -d

cache:
	mkdir -p ./srcs/Data/mysql
	docker-compose -f $(SRC) up -d


clean:
	docker-compose -f $(SRC) down --volumes --remove-orphans
	rm -rf /home/rchavez/data/*

down:
	docker-compose -f $(SRC) down

stop:
	docker-compose -f $(SRC) stop

start:
	docker-compose -f $(SRC) start

status:
	docker ps

purge:
	@if [ "$$(docker ps -aq)" != "" ]; then docker rm -f $$(docker ps -aq); fi
	@if [ "$$(docker images -q)" != "" ]; then docker rmi -f $$(docker images -q); fi
	@if [ "$$(docker volume ls -q)" != "" ]; then docker volume rm $$(docker volume ls -q); fi
	@for net in $$(docker network ls --format '{{.Name}}' | grep -v -E '^bridge$$|^host$$|^none$$'); do \
		docker network rm $$net; \
	done
	@rm -rf ./srcs/data/mysql
	@rm -rf ./srcs/data/wordpress

prune:
	docker network prune -f
	docker container prune -f
	docker image prune -a -f
	docker volume prune -f

restart-docker:
	osascript -e 'quit app "Docker"'
	sleep 5
	bash /Users/${USER}/.docker_valgrind_setup/init_docker.sh

wait:
	@echo "Waiting for MySQL to be ready..."
	@docker exec -it mariadb bash -c 'until mysqladmin ping --silent; do echo "Waiting for MySQL..."; sleep 1; done'
	@echo "MySQL is ready!"

re: clean prune purge restart-docker