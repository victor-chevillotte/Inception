NAME = inception

all: prune reload

linux:
	@ echo "127.0.0.1 vchevill.42.fr" >> /etc/hosts
	
stop:
	@ docker-compose -f srcs/docker-compose.yml down

clean: stop
	@docker stop $$(docker ps -qa);\

fullclean:
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

prune: clean
	@ docker system prune -f

reload: 
	@ docker-compose -f srcs/docker-compose.yml up --build

.PHONY: linux stop clean prune reload all
