# alpine-vuetorrent

An alpine-based image for qbittorrent + vuetorrent.

See also [@3xpo/alpine-qb](https://codeberg.org/Expo/containers/src/branch/master/containers/alpine/qbittorrent).

Set `$AUTO_UPDATE_VUETORRENT` to `true` to have vuetorrent be update checked every hour at :00

I am not responsible for any legality-related side-effects your use of this image may have. Torrent legally and responsibly ;)

## Volumes

- `${HOME}/.config/qBittorrent`: qBittorrent Config
- `${HOME}/Downloads`: Default Downloads directory

## Example Usage

### Docker/Podman Run

- `docker run -it --rm -p 127.0.0.1:8080:8080 -v "/etc/qbittorrent:/home/qb/.config/qBittorrent:rw" -v "/var/qbittorrent:/home/qb/.local/share/qBittorrent:rw" -v "$HOME/qBittorrent-Downloads:/home/qb/Downloads" docker.io/3xpo/alpine-vuetorrent:latest`
- `podman run -it --rm -p 127.0.0.1:8080:8080 -v "/etc/qbittorrent:/home/qb/.config/qBittorrent:rw" -v "/var/qbittorrent:/home/qb/.local/share/qBittorrent:rw" -v "$HOME/qBittorrent-Downloads:/home/qb/Downloads:rw" docker.io/3xpo/alpine-vuetorrent:latest`

### Docker/Podman Compose

```yml
services:
  qbittorrent:
    image: docker.io/3xpo/alpine-vuetorrent:latest
    ports:
      - '127.0.0.1:8080:8080'
    volumes:
      - '/etc/qbittorrent:/home/qb/.config/qBittorrent:rw'
      - '/var/qbittorrent:/home/qb/.local/share/qBittorrent:rw'
      - '/home/<username>/qBittorrent-Downloads:/home/qb/Downloads:rw'
```

(you will need to run `<docker|podman> compose logs qbittorrent` on first launch to get the one-time password)
