# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: phemsi-a <phemsi-a@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/27 20:58:33 by phemsi-a          #+#    #+#              #
#    Updated: 2022/04/27 21:00:59 by phemsi-a         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

MARIA_DB_DIR = ./requirements/mariadb/
NGINX_DIR = ./requirements/nginx/
WORDPRESS_DIR = ./requirements/wordpress/


all: docker-compose 
