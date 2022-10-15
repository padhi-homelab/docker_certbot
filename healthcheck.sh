#!/bin/sh

[ "$(cat ${CERTBOT_LAST_RUN_STATUS_FILE})" -eq "0" ] || exit 1
