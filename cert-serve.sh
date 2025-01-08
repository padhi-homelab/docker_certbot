#!/bin/sh

CERTBOT=/opt/certbot/venv/bin/certbot
CERTBOT_FREQUENCY=${CERTBOT_FREQUENCY:-12h}

trap exit TERM

$CERTBOT certonly --verbose \
                  --non-interactive \
                  --standalone \
                  --agree-tos \
                  --no-eff-email \
                  --keep-until-expiring \
                  --key-type ecdsa \
                  ${CERTBOT_EXTRA_FLAGS} \
                  --email ${CERTBOT_EMAIL} \
                  --domain ${CERTBOT_DOMAIN}

while : ; do
  $CERTBOT renew
  echo $? > ${CERTBOT_LAST_RUN_STATUS_FILE}

  echo "Sleeping for ${CERTBOT_FREQUENCY} ..."
  sleep ${CERTBOT_FREQUENCY} &
  wait $!
done
