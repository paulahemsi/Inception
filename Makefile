# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: phemsi-a <phemsi-a@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/27 20:58:33 by phemsi-a          #+#    #+#              #
#    Updated: 2022/05/02 22:41:03 by phemsi-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


MARIA_DB_DIR = ./srcs/requirements/mariadb/
NGINX_DIR = ./srcs/requirements/nginx/
WORDPRESS_DIR = ./srcs/requirements/wordpress/

all:
	docker-compose -f srcs/docker-compose.yml up --build -d

down:
	docker-compose -f srcs/docker-compose.yml down

nginx:
		docker build -t nginx $(NGINX_DIR)
		docker run -d --name nginx -p 80:80 -p 443:443 nginx

wordpress:
		docker build -t wordpress $(WORDPRESS_DIR)
		docker run -d --name wordpress -p 9000:9000 wordpress

clean:
		docker stop nginx
		docker rm wordpress
		docker stop wordpress
		docker rm nginx

fclean:
		make clean
		docker rmi wordpress
		docker rmi nginx

re:
		make fclean
		make nginx
		make wordpress
