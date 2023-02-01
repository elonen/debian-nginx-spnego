#!/bin/bash
set -e

IMG="build-spnego-nginx-deb:latest"

docker build -t $IMG .
docker run --rm -iv${PWD}:/root/OUTPUT $IMG sh -s << EOF
    cd /root
    make build || exit 1
    chown -v $(id -u):$(id -g) /root/TARGET/*.deb
    cp -va /root/TARGET/*spnego*.deb /root/OUTPUT
    echo "============ Result: ============="
EOF
echo "=============== $(pwd) ==============="
ls -l *spnego*.deb
