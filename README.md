# docker_certbot <a href='https://github.com/padhi-homelab/docker_certbot/actions?query=workflow%3A%22Docker+CI+Release%22'><img align='right' src='https://img.shields.io/github/workflow/status/padhi-homelab/docker_certbot/Docker%20CI%20Release?logo=github&logoWidth=24&style=flat-square'></img></a>

<a href='https://hub.docker.com/r/padhihomelab/certbot'><img src='https://img.shields.io/docker/image-size/padhihomelab/certbot/latest?label=size%20%5Blatest%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>
<a href='https://hub.docker.com/r/padhihomelab/certbot'><img src='https://img.shields.io/docker/image-size/padhihomelab/certbot/testing?label=size%20%5Btesting%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>

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
[standalone]:        https://eff-certbot.readthedocs.io/en/stable/using.html#standalone
