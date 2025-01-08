FROM padhihomelab/alpine-base:3.21.1_0.19.0_0.2


ARG CERTBOT_VERSION=3.1.0
ARG CERTBOT_SHA_512=efd0b0c1540a6e3b631fa80eac65c9e8b31b1e5e1242f56d3723ca7e1b1b2121dfe1bf8e122fe9a9b994460553f1fa085b11d1369b3160f5c51c939b2cccd638

# We set this environment variable and install git while building to try and
# increase the stability of fetching the rust crates needed to build the
# cryptography library
ARG CARGO_NET_GIT_FETCH_WITH_CLI=true


ADD "https://github.com/certbot/certbot/archive/refs/tags/v${CERTBOT_VERSION}.tar.gz" \
    /tmp/certbot.tar.gz


# Adapted from:
# https://github.com/certbot/certbot/blob/main/tools/docker/Dockerfile
RUN cd /tmp \
 && echo "${CERTBOT_SHA_512}  certbot.tar.gz" > certbot.tar.gz.sha512 \
 && sha512sum -c certbot.tar.gz.sha512 \
 && tar -xvzf certbot.tar.gz \
 && cd certbot-${CERTBOT_VERSION} \
 && mkdir -p /opt/certbot/src \
 && cp -r tools /opt/certbot/ \
 && cp -r acme /opt/certbot/src/ \
 && cp -r certbot /opt/certbot/src/ \
 && cd /opt/certbot \
 && rm -rf /tmp/* \
 && apk add --no-cache \
            binutils \
            ca-certificates \
            libffi \
            libssl3 \
            openssl \
            python3 \
 && apk add --no-cache --virtual .build-deps \
            cargo \
            gcc \
            git \
            libffi-dev \
            linux-headers \
            musl-dev \
            openssl-dev \
            pkgconfig \
            python3-dev \
 && python3 -m venv /opt/certbot/venv \
 && CARGO_LOG=trace CARGO_TERM_VERBOSE=true \
    /opt/certbot/venv/bin/python3 tools/pip_install.py --no-cache-dir -vvv \
                                                       --editable src/acme \
                                                       --editable src/certbot \
 && apk del .build-deps \
 && rm -rf ${HOME}/.cargo


COPY cert-serve.sh \
     /usr/local/bin/cert-serve
COPY healthcheck.sh \
     /healthcheck.sh
COPY entrypoint-scripts \
     /etc/docker-entrypoint.d/99-extra-scripts


RUN chmod +x /etc/docker-entrypoint.d/99-extra-scripts/*.sh \
             /usr/local/bin/cert-serve \
             /healthcheck.sh


EXPOSE 80
VOLUME [ "/etc/letsencrypt" ]


CMD [ "cert-serve" ]


ENV CERTBOT_LAST_RUN_STATUS_FILE=/var/log/letsencrypt/last_run.status

HEALTHCHECK --start-period=60s --interval=6h \
        CMD /healthcheck.sh
