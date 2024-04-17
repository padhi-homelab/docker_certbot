# docker_certbot 

[![build status](https://img.shields.io/github/actions/workflow/status/padhi-homelab/docker_certbot/docker-release.yml?label=BUILD&branch=main&logo=github&logoWidth=24&style=flat-square)](https://github.com/padhi-homelab/docker_certbot/actions?query=workflow%3A%22Docker+CI+Release%22)
[![testing size](https://img.shields.io/docker/image-size/padhihomelab/certbot/testing?label=SIZE%20%5Btesting%5D&logo=docker&logoColor=skyblue&logoWidth=24&style=flat-square)](https://hub.docker.com/r/padhihomelab/certbot/tags)
[![latest size](https://img.shields.io/docker/image-size/padhihomelab/certbot/latest?label=SIZE%20%5Blatest%5D&logo=docker&logoColor=skyblue&logoWidth=24&style=flat-square)](https://hub.docker.com/r/padhihomelab/certbot/tags)

[![latest version](https://img.shields.io/docker/v/padhihomelab/certbot/latest?label=LATEST&logo=linux-containers&logoWidth=20&labelColor=darkmagenta&color=gold&style=for-the-badge)](https://hub.docker.com/r/padhihomelab/certbot/tags)
[![image pulls](https://img.shields.io/docker/pulls/padhihomelab/certbot?label=PULLS&logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAzMiAzMiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBmaWxsPSIjZmZmIj4KICAgIDxwYXRoIGQ9Ik0yMC41ODcsMTQuNjEzLDE4LDE3LjI0NlY5Ljk4QTEuOTc5LDEuOTc5LDAsMCwwLDE2LjAyLDhoLS4wNEExLjk3OSwxLjk3OSwwLDAsMCwxNCw5Ljk4djYuOTYzbC0uMjYtLjA0Mi0yLjI0OC0yLjIyN2EyLjA5MSwyLjA5MSwwLDAsMC0yLjY1Ny0uMjkzQTEuOTczLDEuOTczLDAsMCwwLDguNTgsMTcuNGw2LjA3NCw2LjAxNmEyLjAxNywyLjAxNywwLDAsMCwyLjgzMywwbDUuOTM0LTZhMS45NywxLjk3LDAsMCwwLDAtMi44MDZBMi4wMTYsMi4wMTYsMCwwLDAsMjAuNTg3LDE0LjYxM1oiLz4KICAgIDxwYXRoIGQ9Ik0xNiwwQTE2LDE2LDAsMSwwLDMyLDE2LDE2LDE2LDAsMCwwLDE2LDBabTAsMjhBMTIsMTIsMCwxLDEsMjgsMTYsMTIuMDEzLDEyLjAxMywwLDAsMSwxNiwyOFoiLz4KICA8L2c+Cjwvc3ZnPgo=&logoWidth=20&labelColor=teal&color=gold&style=for-the-badge)](https://hub.docker.com/r/padhihomelab/certbot)

---

A multiarch [Certbot] Docker image, based on [Alpine Linux].

|           386            |       amd64        |          arm/v6          |       arm/v7       |       arm64        |         ppc64le          |          s390x           |
| :----------------------: | :----------------: | :----------------------: | :----------------: | :----------------: | :----------------------: | :----------------------: |
| :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_multiplication_x: |

## Usage

### With Docker

```sh
docker run -p 80:80 -it padhihomelab/certbot \
           -e CERTBOT_EMAIL=email@my.domain.org \
           -e CERTBOT_DOMAIN=my.domain.org
```

Runs [Certbot] with a [standalone] server on port 80,
and checks for certificate renewals every 12h be default
<br>
To run it in background, use the `--detach` flag.

Usage with [Docker Compose] is similarly straightforward.
<br>
As an example, you can see my configuration in [services/certbot].

[Alpine Linux]:      https://alpinelinux.org/
[Docker Compose]:    https://docs.docker.com/compose/
[Certbot]:           https://github.com/certbot/certbot
[services/certbot]:  https://github.com/padhi-homelab/services/tree/main/certbot
[standalone]:        https://eff-certbot.readthedocs.io/en/stable/using.html#standalone
