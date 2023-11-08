.PHONY: build up down clean sql-shell rebuild logs

COMPOSE_FILE := ./srcs/docker-compose.yml

build:
	@echo "Construire tous les conteneurs..."
	docker-compose -f $(COMPOSE_FILE) build

up:
	@echo "Lancement des conteneurs..."
	docker-compose -f $(COMPOSE_FILE) up -d

down:
	@echo "Arrêt des conteneurs..."
	docker-compose -f $(COMPOSE_FILE) down

clean:
	@echo "Nettoyage de l'environnement..."
	docker-compose -f $(COMPOSE_FILE) down --rmi all --volumes --remove-orphans

rebuild: down build up

logs:
	@echo "Affichage des logs..."
	docker-compose -f $(COMPOSE_FILE) logs

sql-shell:
	@echo "Accès au shell MySQL..."
	docker-compose -f $(COMPOSE_FILE) exec db mysql -u root
