create-migration:
	migrate create -ext sql -dir . ${FILENAME}
.PHONY: create-migration

migrate-up:
	migrate -path=migrations/ -database sqlite3://${DB} up
.PHONY: migrate-up
migrate-down:
	migrate -path=migrations -database sqlite3://${DB} down
.PHONY: migrate-down

migrate-up-docker:
	docker run -v migrations:/migrations --network host migrate/migrate -path=/migrations/ -database sqlite://${DB} up 0
.PHONY: migrate-up-docker

build:
	go build -o gpodder2go main.go
.PHONY: build
