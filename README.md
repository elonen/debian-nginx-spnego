# debian-nginx-spnego

Scripts for building a fresh Debian package
`libnginx-mod-http-auth-spnego` from latest version of
https://github.com/stnoonan/spnego-http-auth-nginx-module

Run `./build-in-docker.sh`, and it will build `.deb` files for Debian Bullseye and Bookworm on AMD64 and ARM64.
The only dependency is Docker, everything else will be installed inside it as necessary.

## What does it do?

### 1. On Bookworm (Debian 12)

Simply adds a minimal `debian/` directory and builds the package as usual with `dpkb-buildpackage`.

### 2. On Bullseye (Debian 11)

Injects the latest spnego module into Debian Nginx source package
(maintained at https://salsa.debian.org/nginx-team/nginx) and recompiles.
Roughly:

 1. Checks out latest versio of stnoonan/spnego-http-auth-nginx-module from Github
 2. `apt-get source nginx`
 3. apply patch `nginx-spnego-deb.patch`
 4. `dpkb-buildpackage -b -us -uc`

## Authorization

To get Active Directory authorization (against groups) in addition to
authentication, check out this: https://github.com/elonen/ldap_authz_proxy
