PKGNAME := minimal-prompt

PKGVER := $(shell git rev-parse --short HEAD)
PKGREL := $(shell date +%Y%m%d)

PREFIX ?= /usr

prepare: clean
	sed 's/PKGVER/$(PKGVER)/g;s/PKGREL/$(PKGREL)/g' PKGBUILD.template > PKGBUILD
	tar czf "${PKGNAME}-$(PKGVER).tar.gz" ${PKGNAME}.zsh Makefile

install:
	mkdir -p $(PREFIX)/share/zsh/plugins/${PKGNAME}
	install -Dm644 ${PKGNAME}.zsh $(PREFIX)/share/zsh/plugins/${PKGNAME}/${PKGNAME}.zsh

clean:
	rm -rf *tar.gz *.pkg.tar.zst pkg src PKGBUILD