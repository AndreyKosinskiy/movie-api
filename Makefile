current_time = $(shell date --iso-8601=seconds)
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

.PHONY: build/api
build/api:
	@echo 'Building cmd/api...'
	go build -ldflags='-s' -o=./bin/api ./cmd/api
	GOOS=linux GOARCH=amd64 go build -ldflags='-s -X main.buildTime=${current_time}' -o=./bin/linux_amd64/api ./cmd/api

run:
	go run ./cmd/api
test:
	go test ./...

migrate.up:
	migrate -path ./migrations -database postgres://greenlight:pa55word@localhost/greenlight?sslmode=disable up