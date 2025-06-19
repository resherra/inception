GREEN=\033[1;32m
YELLOW=\033[1;33m
BLUE=\033[1;34m
RED=\033[1;31m
NC=\033[1m  

DOMAIN=recherra.42.fr
VOLUME_PATH=/home/recherra/data

all:
	@echo "$(YELLOW)Creating the following mount points: \n$(BLUE)\
	- $(VOLUME_PATH)/wp \n\
	- $(VOLUME_PATH)/mdb$(NC)"
	@sudo mkdir -p $(VOLUME_PATH)/wp
	@sudo mkdir -p $(VOLUME_PATH)/mdb
	@echo "$(GREEN)Mount points created successfully$(NC)\n"

	@echo "$(YELLOW)Adding ${DOMAIN} domain name to /etc/hosts$(NC)"
	@sudo sh -c 'if ! grep -q "${DOMAIN}" /etc/hosts; then echo "127.0.0.1 ${DOMAIN}" >> /etc/hosts; fi'

	@echo "\n$(YELLOW)start building...$(NC)\n"
	@cd srcs && docker compose up --build
# cd srcs && docker compose build --no-cache && docker compose up

down:
	@cd srcs && docker compose down  -v --rmi local

clean:
	@sudo rm -rf $(VOLUME_PATH)
	@echo "$(GREEN)removing the following dirs: \n\
		- $(VOLUME_PATH)/wp\n\
		- $(VOLUME_PATH)/mdb\n"
	@echo "removing $(DOMAIN) domain name from /etc/hosts"
	@sudo sed -i '/recherra.42.fr/d' /etc/hosts
