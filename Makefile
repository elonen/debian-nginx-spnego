.phony: build clean
.ONESHELL: # Make cd work (don't use separate subshells for commands)

default:
	@echo "This needs to be ran as root. You'll probably want do ./build-in-docker.sh instead."

clean:
	rm -rf TARGET

# Debian Bullseye: Inject module inside Nginx source tree and build.
build-bullseye:
	set -e
	mkdir TARGET
	cd TARGET
	git clone https://github.com/stnoonan/spnego-http-auth-nginx-module.git
	apt-get update
	apt-get -y install libkrb5-dev nginx-common
	apt-get -y source nginx
	cd $$(ls -d nginx-1*) || exit 1
	patch -p 1 < ../../nginx-spnego-deb-bullseye.patch
	cp -a ../spnego-http-auth-nginx-module debian/modules/http-auth-spnego
	cp -a debian/libnginx-mod-http-auth-pam.nginx debian/libnginx-mod-http-auth-spnego.nginx
	apt-get install --yes $$(dpkg-checkbuilddeps 2>&1 | sed -e 's/dpkg-checkbuilddeps:\serror:\sUnmet build dependencies: //g' -e  's/[\(][^)]*[\)] //g')
	dpkg-buildpackage -b -us -uc

# Debian Bookworm: Use custom debian/ files and build with dpkg-buildpackage as usual.
build-bookworm:
	set -e
	mkdir TARGET
	cd TARGET
	git clone https://github.com/stnoonan/spnego-http-auth-nginx-module.git
	apt-get update
	apt-get -y install libkrb5-dev nginx-common
	cd spnego-http-auth-nginx-module
	ls ../../
	cp -a ../../debian_bookworm debian
	cp LICENSE debian/copyright
	apt-get install --yes $$(dpkg-checkbuilddeps 2>&1 | sed -e 's/dpkg-checkbuilddeps:\serror:\sUnmet build dependencies: //g' -e  's/[\(][^)]*[\)] //g')
	dpkg-buildpackage -b -us -uc
