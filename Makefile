# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: phemsi-a <phemsi-a@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/27 20:58:33 by phemsi-a          #+#    #+#              #
#    Updated: 2022/04/29 22:53:03 by phemsi-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

$(NAME): up

MARIA_DB_DIR = ./srcs/requirements/mariadb/
NGINX_DIR = ./srcs/requirements/nginx/
WORDPRESS_DIR = ./srcs/requirements/wordpress/

all: $(NAME)

$(NAME): docker-compose up

down: docker-compose down

nginx:
		docker build -t nginx $(NGINX_DIR)
		docker run --name nginx -p 80:80 -p 443:443 nginx
