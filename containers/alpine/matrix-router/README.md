# matrix-clients

Caddy server for Matrix clients.

Please define the `/var/lib/caddy/` volume when using this image.

## Env Variables

| Name                            | Description                                                                          | Default |
| ------------------------------- | ------------------------------------------------------------------------------------ | ------- |
| `LISTEN_ON`                     | Describes what to listen on; the name given to caddy - for example, `example.com:80` | `:80`   |
| `ALLOW_FRAMING`                 | Allows iframing the page if `true`, otherwise tells browsers not to.                 | null    |
| `DISABLE_XSS_PROTECTION`        | Disables `X-XSS-Protection` if `true`, otherwise enables it.                         | null    |
| `DISABLE_NOSNIFF`               | Disables `X-Content-Type-Options` if `true`, otherwise enables it.                   | null    |
| `FEDERATION_TARGET`             | Sets the `m.server` value in `.well-known/matrix/server`                             | null    |
| `HOMESERVER_BASE_URL`           | Sets the `m.homeserver`->`base_url` value in `.well-known/matrix/client`             | null    |
| `PROXY_MATRIX_TRAFFIC_TO`       | Proxies `/_matrix/*` to the value of the variable if set.                            | null    |
| `REDIRECT_MATRIX_TRAFFIC_TO`    | Same as `PROXY_MATRIX_TRAFFIC_TO` but with http redirects                            | null    |
| `USE_PERMANENT_MATRIX_REDIRECT` | If `true`, will use permanent redirects for `PROXY_MATRIX_TRAFFIC_TO`                | null    |
| `DEFAULT_CLIENT_HOMESERVER`     | The default homeserver to use for clients                                            | null    |

Note that you can overwrite `/.well-known/matrix/*` files by mounting a volume to `/var/www/html/.well-known/matrix`.

`PROXY_MATRIX_TRAFFIC_TO` and `REDIRECT_MATRIX_TRAFFIC_TO` cannot be used at the same time.

`LISTEN_ON` should not be set to anything but `:<port>` if you are using a reverse proxy.

## Files to overwrite

You may want to overwrite these files:

- `/var/www/html/index.html`: Client Selection thing
- `/var/www/html/element/config.json`: The element config
- `/var/www/html/fluffychat/config.json`: The fluffychat config
- `/var/www/html/.well-known/matrix/{client,server}`: Matrix configuration files
