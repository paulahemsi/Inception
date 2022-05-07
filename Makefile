# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: phemsi-a <phemsi-a@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/27 20:58:33 by phemsi-a          #+#    #+#              #
#    Updated: 2022/05/05 20:15:22 by phemsi-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


MARIA_DB_DIR = ./srcs/requirements/mariadb/
NGINX_DIR = ./srcs/requirements/nginx/
WORDPRESS_DIR = ./srcs/requirements/wordpress/

all:
	docker-compose -f srcs/docker-compose.yml up --build -d

down:
	docker-compose -f srcs/docker-compose.yml down
