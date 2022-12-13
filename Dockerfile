FROM padhihomelab/alpine-base:3.17.0_0.19.0_0.2


ARG CERTBOT_VERSION=2.1.0


ADD "https://github.com/certbot/certbot/archive/refs/tags/v${CERTBOT_VERSION}.tar.gz" \
    /tmp/certbot.tar.gz


# We set this environment variable and install git while building to try and
# increase the stability of fetching the rust crates needed to build the
# cryptography library
ARG CARGO_NET_GIT_FETCH_WITH_CLI=true

# Adapted from:
# https://github.com/certbot/certbot/blob/master/tools/docker/core/Dockerfile
RUN cd /tmp \
 && tar -xvzf certbot.tar.gz \
 && cd certbot-${CERTBOT_VERSION} \
 && mkdir -p /opt/certbot/src \
 && cp -r tools /opt/certbot/ \
 && cp -r acme /opt/certbot/src/ \
 && cp -r certbot /opt/certbot/src/ \
 && cp certbot/CHANGELOG.md \
       certbot/README.rst \
       /opt/certbot/src/ \
 && cd /opt/certbot \
 && rm -rf /tmp/* \
 && apk add --no-cache \
            binutils \
            ca-certificates \
            libffi \
            libssl1.1 \
            openssl \
            python3 \
            py3-pip \
 && apk add --no-cache --virtual .build-deps \
            cargo \
            gcc \
            git \
            libffi-dev \
            linux-headers \
            musl-dev \
            openssl-dev \
            python3-dev \
 && python3 tools/pipstrap.py \
 && python3 tools/pip_install.py --no-cache-dir \
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
