# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rchavez@student.42heilbronn.de <rchavez    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/28 17:01:32 by rchavez@stu       #+#    #+#              #
#    Updated: 2025/04/28 17:04:17 by rchavez@stu      ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRC = ./srcs/docker-compose.yml

up:
	docker-compose -f ${SRC} up -d

down:
	docker-compose -f $(SRC) down

stop:
	docker-compose -f $(SRC) stop

start:
	docker-compose -f $(SRC) start

status:
	docker ps