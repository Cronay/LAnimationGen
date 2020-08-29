binary=lAnimationGen
prefix=/usr/local
project=LAnimationGen-CLI
build_folder=.build
release_binary_folder=$(build_folder)/release/$(project)
version=v0.0.1

build:
	swift build --disable-sandbox -c release

clean:
	swift package clean

install: build
	mkdir -p $(prefix)/bin
	cp -f $(release_binary_folder) $(prefix)/bin/$(binary)

uninstall:
	rm -f $(prefix)/bin/$(binary)
