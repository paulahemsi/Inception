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

VOLUME_DIR = /home/phemsi-a/data/
WORDPRESS_VOLUME_DIR = $(VOLUME_DIR)wordpress
MARIADB_VOLUME_DIR = $(VOLUME_DIR)mysql
DOMAIN	=	$(shell awk '/phemsi-a.42.fr/{print $$2}' /etc/hosts)

all: volume hosts
	cd srcs/ && docker-compose -f docker-compose.yml up --build -d

volume:
	sudo mkdir -p $(MARIADB_VOLUME_DIR)
	sudo mkdir -p $(WORDPRESS_VOLUME_DIR)
	docker volume create --name wordpress --opt type=none --opt device=$(WORDPRESS_VOLUME_DIR) --opt o=bind
	docker volume create --name dbdata --opt type=none --opt device=$(MARIADB_VOLUME_DIR) --opt o=bind

hosts:
ifneq (${DOMAIN},phemsi-a.42.fr)
	cp /etc/hosts ./hosts_backup
	sudo rm /etc/hosts
	sudo cp ./srcs/requirements/tools/hosts /etc/
endif

down:
	cd srcs/ && docker-compose -f docker-compose.yml down

clean:
	docker volume rm wordpress
	docker volume rm dbdata
	sudo rm -rf /home/phemsi-a/data

fclean:
	docker system prune -a --volumes
	sudo rm /etc/hosts
	sudo mv ./hosts_backup /etc/hosts
