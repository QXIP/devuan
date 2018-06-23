
RELEASE = ascii

PROJECT = devuan

REPO = qxip

CONTAINER = $(REPO)/$(PROJECT):$(RELEASE)

LATEST = $(REPO)/$(PROJECT):latest

TARGETDIR = debootstrap/devuan

all: preinstall debootstrap/devuan image

preinstall:
	sudo apt-get install -y debootstrap

debootstrap/devuan:
	cd debootstrap && make install && sudo ./debootstrap --no-check-gpg --arch amd64 $(RELEASE) devuan/ https://packages.devuan.org/merged/

image:
	sudo chroot $(TARGETDIR) apt-get clean
	cd debootstrap && sudo tar -C devuan -c . | docker import - $(CONTAINER)
	docker images | grep devuan | grep $(RELEASE)

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

