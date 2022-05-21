# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: phemsi-a <phemsi-a@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/27 20:58:33 by phemsi-a          #+#    #+#              #
#    Updated: 2022/05/17 21:25:43 by phemsi-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


MARIA_DB_DIR = ./srcs/requirements/mariadb/
NGINX_DIR = ./srcs/requirements/nginx/
WORDPRESS_DIR = ./srcs/requirements/wordpress/
DOMAIN	=	$(shell awk '/phemsi-a.42.fr/{print $$2}' /etc/hosts)

all:
ifneq (${DOMAIN},phemsi-a.42.fr)
	cp /etc/hosts ./hosts_backup
	sudo rm /etc/hosts
	sudo cp ./srcs/requirements/tools/hosts /etc/
endif
	cd srcs/ && docker-compose -f docker-compose.yml up --build -d

down:
	cd srcs/ && docker-compose -f docker-compose.yml down

fclean:
	docker system prune -a --volumes
	sudo rm /etc/hosts
	sudo mv ./hosts_backup /etc/hosts
