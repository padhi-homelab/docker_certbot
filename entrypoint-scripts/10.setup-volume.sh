#!/bin/sh -e

mkdir -p /var/lib/letsencrypt \
         /var/log/letsencrypt

if [ -z "${ENTRYPOINT_RUN_AS_ROOT:-}" ]; then
  chown -R $DOCKER_USER:$DOCKER_GROUP \
        /etc/letsencrypt \
        /var/lib/letsencrypt \
        /var/log/letsencrypt
fi
