default: docker

docker:
	docker build -t vibioh/logspout --rm .
