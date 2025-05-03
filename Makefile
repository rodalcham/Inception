# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rchavez <rchavez@student.42heilbronn.de    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 17:01:32 by rchavez@stu       #+#    #+#              #
#    Updated: 2025/05/03 16:06:07 by rchavez          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRC = ./srcs/docker-compose.yml

up:
	mkdir -p ./srcs/Data/mysql
	chmod 755 ./srcs/Data/mysql
	sleep 1
	docker-compose -f $(SRC) build --no-cache
	docker-compose -f $(SRC) up -d

cache:
	mkdir -p ./srcs/Data/mysql
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

purge:
	@if [ "$$(docker ps -aq)" != "" ]; then docker rm -f $$(docker ps -aq); fi
	@if [ "$$(docker images -q)" != "" ]; then docker rmi -f $$(docker images -q); fi
	@if [ "$$(docker volume ls -q)" != "" ]; then docker volume rm $$(docker volume ls -q); fi
	@for net in $$(docker network ls --format '{{.Name}}' | grep -v -E '^bridge$$|^host$$|^none$$'); do \
		docker network rm $$net; \
	done
	@rm -rf ./srcs/data/mysql

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