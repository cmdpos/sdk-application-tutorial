
all: install

install:
	go install ./cmd/nsd
	go install ./cmd/nscli

go.sum: go.mod
	@echo "--> Ensure dependencies have not been modified"
	@go mod verify
