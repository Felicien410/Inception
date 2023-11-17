# Colors
RED = \033[1;31m
GREEN = \033[1;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
PURPLE = \033[1;35m
RESET = \033[0m


COMPOSE_FILE = ./srcs/docker-compose.yml

all: build up

build:
	@echo "$(BLUE)██████████████████████ Building Images ███████████████████████$(RESET)"
	docker-compose -f $(COMPOSE_FILE) build

up:
	@echo "$(GREEN)██████████████████████ Running Containers ██████████████████████$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) up -d
	@echo "$(RED)╔════════════════════════════║NOTE:║════════════════════════╗$(RESET)"
	@echo "$(RED)║   $(BLUE) You can see The Containers logs using $(YELLOW)make logs        $(RED)║$(RESET)"
	@echo "$(RED)╚═══════════════════════════════════════════════════════════╝$(RESET)"

down:
	@echo "$(RED)██████████████████ Removing All Containers ██████████████████$(RESET)"
	docker-compose -f $(COMPOSE_FILE) down

start:
	@echo "$(RED)████████████████████ Starting Containers █████████████████████$(RESET)"
	docker-compose -f $(COMPOSE_FILE) start

stop:
	@echo "$(RED)████████████████████ Stoping Containers █████████████████████$(RESET)"
	docker-compose -f $(COMPOSE_FILE) stop

logs:
	@echo "$(GREEN)██████████████████████ Running Containers ██████████████████████$(RESET)"
	docker-compose -f $(COMPOSE_FILE) logs
	
status:
	@echo "$(GREEN)██████████████████████ The Running Containers ██████████████████████$(RESET)"
	docker ps

prune: down
	@echo "$(RED)█████████████████████ Remove Everything ██████████████████████$(RESET)"
	@sudo rm -rf srcs/data
	@docker system prune -f

rmi:
	@echo "$(RED)█████████████████████ Deleting Images ██████████████████████$(RESET)"
	@docker rmi srcs_wordpress srcs_mariadb srcs_nginx srcs_ftp-server srcs_redis

clean:
	@echo "$(RED)█████████████████████ Removing Containers ██████████████████████$(RESET)"
	docker-compose -f $(COMPOSE_FILE) down --volumes --remove-orphans

fclean:
	@echo "$(RED)█████████████████████ Removing Everything ██████████████████████$(RESET)"
	@docker-compose -f srcs/docker-compose.yml down || echo "Docker Compose n'a pas pu arrêter les conteneurs. Peut-être n'existent-ils pas ou sont-ils déjà arrêtés."
	@docker system prune -a --volumes

re: fclean all

.PHONY: all build up down start stop logs status prune rmi re banner

sql-shell:
	@echo "Accès au shell MySQL..."
	docker-compose -f $(COMPOSE_FILE) exec db mysql -u root
