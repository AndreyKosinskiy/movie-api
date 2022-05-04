test:
	go test ./...

migrate.up:
	migrate -path ./migrations -database postgres://greenlight:pa55word@localhost/greenlight?sslmode=disable up