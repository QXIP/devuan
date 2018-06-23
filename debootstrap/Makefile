# avoid dpkg-dev dependency; fish out the version with sed
VERSION := $(shell sed 's/.*(\(.*\)).*/\1/; q' debian/changelog)

all:

clean:

DSDIR=$(DESTDIR)/usr/share/debootstrap
install:
	sudo mkdir -p $(DSDIR)/scripts
	#sudo mkdir -p $(DESTDIR)/usr/sbin

	sudo cp scripts/ceres $(DSDIR)/scripts/
	sudo cp scripts/ascii $(DSDIR)/scripts/
	#sudo install -o root -g root -m 0644 functions $(DSDIR)/

	#sudo sed 's/@VERSION@/$(VERSION)/g' debootstrap >$(DESTDIR)/usr/sbin/debootstrap
	#sudo chown root:root $(DESTDIR)/usr/sbin/debootstrap
	#sudo chmod 0755 $(DESTDIR)/usr/sbin/debootstrap
