
RELEASE = jessie

PROJECT = devuan

REPO = qxip

CONTAINER = $(REPO)/$(PROJECT):$(RELEASE)

LATEST = $(REPO)/$(PROJECT):latest

TARGETDIR = debootstrap/devuan

all: debootstrap/devuan image

debootstrap/devuan:
	cd debootstrap && sudo ./debootstrap --no-check-gpg --arch amd64 $(RELEASE) devuan/ https://packages.devuan.org/merged/

image:
	sudo chroot $(TARGETDIR) apt-get clean
	cd debootstrap && sudo tar -C devuan -c . | docker import - $(CONTAINER)

push:
	docker push $(CONTAINER)
	docker tag $(CONTAINER) $(LATEST)
	docker push $(LATEST)

clean:
	test -d $(TARGETDIR) && sudo rm -rf $(TARGETDIR); echo

ci: clean all

test1:
	docker run -it $(CONTAINER) /bin/bash

test2:
	docker run -it $(LATEST) /bin/bash

