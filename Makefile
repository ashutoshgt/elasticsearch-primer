run:
	@docker network create elastic || true
	@docker-compose up
