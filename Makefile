VERSION=v1.2.0-alpha.3

all:
  docker build -t guybrush/hyperkube:${VERSION} --build-arg VERSION=${VERSION} .
	docker push guybrush/hyperkube:${VERSION}
  
.PHONY: all