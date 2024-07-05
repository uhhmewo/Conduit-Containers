# alpine-conduit-client

An alpine-based image for [conduit](https://conduit.rs).

This image also comes with 3 clients:

- [Fluffychat](https://fluffychat.im/) (on the `/fluffy` route)
- [Element](https://element.io/) (on the `/element` route)
- [Cinny](https://cinny.in/) (on the `/cinny` route)

The `next` tag builds from master every 2 hours, the `latest` tag builds from the latest non-rc tag every 2 hours, and the `rc` tag does the same but with the latest tag of any kind, rc or not.

Note that `rc` and `latest` are the same for clients that don't have a release candidate.

## Env

You must specify the `CONDUIT_SERVER_NAME` environment variable with a domain that points to your server.

Add a duplicate variable named `SERVER_ADDR` with the identical value prefixed it with `http://` if you don't directly expose the container's ports to the outside world. If you don't prefix it with `http://`, you must pass through `80:80`, or proxy ACME challenges to the container's `80` port.

Aside from that, include your usual conduit env.

For example, if your server runs on `example.com`, you should put `CONDUIT_SERVER_NAME=example.com`. If your server runs on `example.com` and runs behind nginx, you should put `CONDUIT_SERVER_NAME=example.com` and `SERVER_ADDR=http://example.com`.

Oh also, `CONDUIT_PORT` must be 6167.

## Volumes

- `/var/lib/matrix-conduit`: Conduit DB

You may also want to create the following volumes:

- `/var/www/html/index.html`: Change the index page
- `/var/www/html/element/config.<your domain>.json`: The element config used for your domain
- `/var/www/html/element/config.json`: The element default global config
- `/var/www/html/cinny/config.json`: The cinny config
- `/var/www/html/fluffychat/config.json`: The fluffychat config
- `/var/log/caddy.log`, `/var/log/conduit.log`: Logs

## Ports

We expose port `443` by default
