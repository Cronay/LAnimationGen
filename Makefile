BINARY?=carting
BUILD_FOLDER?=.build
OS?=sierra
PREFIX?=/usr/local
PROJECT?=Carting
RELEASE_BINARY_FOLDER?=$(BUILD_FOLDER)/release/$(PROJECT)
VERSION?=0.0.1

build:
	swift build --disable-sandbox -c release

clean:
	swift package clean

install: build
	mkdir -p $(PREFIX)/bin
	cp -f $(RELEASE_BINARY_FOLDER) $(PREFIX)/bin/$(BINARY)
