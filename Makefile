BINARY?=lAnimationGen
PREFIX?=/usr/local
PROJECT?=LAnimationGen
BUILD_FOLDER?=.build
RELEASE_BINARY_FOLDER?=$(BUILD_FOLDER)/release/$(PROJECT)
VERSION?=0.0.1

build:
	swift build --disable-sandbox -c release

clean:
	swift package clean

install: build
	mkdir -p $(PREFIX)/bin
	cp -f $(RELEASE_BINARY_FOLDER) $(PREFIX)/bin/$(BINARY)

uninstall:
	rm -f $(PREFIX)/bin/$(BINARY)
