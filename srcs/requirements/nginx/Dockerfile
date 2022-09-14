FROM debian:buster

RUN echo -e "\033[0;32m nginx docker: Setting up.... \033[0m"
RUN apt-get update
RUN apt-get install -y nginx openssl

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./tools/nginx_start.sh /var/www

RUN chmod +x /var/www/nginx_start.sh

ENTRYPOINT [ "var/www/nginx_start.sh" ]

CMD ["nginx", "-g", "daemon off;"]

RUN echo -e "\033[0;32m nginx docker: Is set up ! \033[0m"
