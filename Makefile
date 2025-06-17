all:
	cd srcs && docker-compose up --build

clean:
	cd srcs && docker-compose down -v

