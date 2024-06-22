FROM docker.io/alpine

RUN apk --no-cache add qbittorrent-nox shadow sudo

COPY <<EOF "/usr/bin/qb-entrypoint"
#!/bin/bash
set -eax
if ! [[ -f ~/.config/qBittorrent/qBittorrent.conf ]]; then
  sudo mkdir -p ~/.config/qBittorrent;
  sudo mv ~/.qb-default-config/* ~/.config/qBittorrent/
fi;
sudo chown -R qb "\${HOME}" "\${HOME}/.config" "\${HOME}/.config/qBittorrent"
rm -rf ~/.qb-default-config/
sudo rm /etc/sudoers.d/qb
exec "\$@"
EOF
# entrypoint removes this:
COPY <<EOF "/etc/sudoers.d/qb"
qb ALL=(ALL:ALL) NOPASSWD: ALL
EOF

ENV HOME="/home/qb"
RUN useradd qb
RUN mkdir -p "${HOME}" && chown -R qb "${HOME}" && chmod +x /usr/bin/qb-entrypoint
USER qb
ENV DOWNLOADS="${HOME}/Downloads"
WORKDIR "${HOME}"
RUN mkdir -p "${DOWNLOADS}" "${HOME}/.qb-default-config"
COPY <<EOF "${HOME}/.qb-default-config/qBittorrent.conf"
[BitTorrent]
Session\Port=20394
Session\QueueingSystemEnabled=false

[LegalNotice]
Accepted=true

[Meta]
MigrationVersion=6

[Network]
Cookies=@Invalid()
EOF
RUN rm -rf "${HOME}/.config/qBittorrent"
EXPOSE 8080
VOLUME [ "${HOME}/.config/qBittorrent", "${DOWNLOADS}" ]

ENTRYPOINT [ "/usr/bin/qb-entrypoint" ]
CMD [ "/usr/bin/qbittorrent-nox" ]
