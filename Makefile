NAME = inception

all: prune reload

linux:
	@ echo "127.0.0.1 vchevill.42.fr" >> /etc/hosts
	
stop:
	@ docker-compose -f srcs/docker-compose.yml down

clean: stop

fullclean:
	docker system prune -a --volumes

prune: clean
	@ docker system prune -f

reload: 
	@ docker-compose -f srcs/docker-compose.yml up --build

.PHONY: linux stop clean prune reload all
