#!/usr/bin/env bash
set -m
/usr/local/bin/docker-entrypoint.sh echo "Bootstrapping application"

cloud=${storage__active}

function setupGCS() {
    mkdir -p /tmp/gcs ${GHOST_CONTENT}/adapters/storage/gcs &&
        wget -O - "$(npm view @danmasta/ghost-gcs-adapter@0.0.3 dist.tarball)" | tar xz -C /tmp/gcs &&
        npm install --prefix /tmp/gcs/package --silent --only=production --no-optional --no-progress &&
        cp -r /tmp/gcs/package/* ${GHOST_CONTENT}/adapters/storage/gcs

}

function setupS3() {
    mkdir -p /tmp/s3 ${GHOST_CONTENT}/adapters/storage/s3 &&
        wget -O - "$(npm view ghost-storage-adapter-s3@v2.8.0 dist.tarball)" | tar xz -C /tmp/s3 &&
        npm install --prefix /tmp/s3/package --silent --only=production --no-optional --no-progress &&
        cp -r /tmp/s3/package/* ${GHOST_CONTENT}/adapters/storage/s3

}

function waitForService() {
    status=1
    while [[ $status -ne "0" ]]; do
        nc -vz data_volume 2368 >&/dev/null || echo "Port not open"
        status=$?
        echo "waiting for port, sleeping for 10 seconds"
        sleep 10
    done
}

if [[ $cloud == "s3" ]]; then
    setupS3
elif [[ $cloud == "gcs" ]]; then
    setupGCS
fi

/usr/local/bin/docker-entrypoint.sh node current/index.js
