#!/bin/bash
set -e

ARCHS=("amd64" "arm64")
DEBIAN_VERSIONS=("bookworm" "bullseye")

for ARCH in "${ARCHS[@]}"; do
    for VERSION in "${DEBIAN_VERSIONS[@]}"; do
    IMG="build-spnego-nginx-deb:${VERSION}-${ARCH}"
        docker build --build-arg DEBIAN_VERSION=${VERSION} --platform linux/${ARCH} -t $IMG .
        docker run --rm -iv${PWD}:/root/OUTPUT $IMG sh -s << EOF
            cd /root
            rm -rf TARGET
            make build-${VERSION} || exit 1
            chown -v $(id -u):$(id -g) /root/TARGET/*.deb
            cp -va /root/TARGET/*spnego*.deb /root/OUTPUT
            echo "============ Result: ============="
EOF
        echo "=============== $(pwd) ==============="
        ls -l *spnego*.deb
    done
done
