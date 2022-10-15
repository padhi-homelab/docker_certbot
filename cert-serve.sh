#!/bin/sh

CERTBOT_FREQUENCY=${CERTBOT_FREQUENCY:-12h}

trap exit TERM

while : ; do
  certbot certonly \
          --verbose \
          --non-interactive \
          --standalone \
          --agree-tos \
          --no-eff-email \
          --keep-until-expiring \
          --key-type ecdsa \
          ${CERTBOT_EXTRA_FLAGS} \
          --email ${CERTBOT_EMAIL} \
          --domain ${CERTBOT_DOMAIN}
  echo $? > ${CERTBOT_LAST_RUN_STATUS_FILE}

  echo "Sleeping for ${CERTBOT_FREQUENCY} ..."
  sleep ${CERTBOT_FREQUENCY} &
  wait $!
done
