# debian-nginx-spnego

Scripts for building a fresh Debian package
`libnginx-mod-http-auth-spnego` from latest version of
https://github.com/stnoonan/spnego-http-auth-nginx-module

Run `./build-in-docker.sh`, and it will setup Debian Bullseye, patch,
compile and finally spit out the `.deb` in current directory.

The only dependency is Docker, everything else will be installed inside it
as necessary.

## What does it do?

Simply injects the latest spnego module into Debian Nginx source package
(maintained at https://salsa.debian.org/nginx-team/nginx) and recompiles.
Roughly:

 1. Checks out latest versio of stnoonan/spnego-http-auth-nginx-module from Github
 2. `apt-get source nginx`
 3. apply patch `nginx-spnego-deb.patch`
 4. `dpkb-buildpackage -b -us -uc`
