FROM docker.io/3xpo/alpine-qb:latest

USER root
COPY <<EOT /usr/bin/update-vuetorrent-job
#!/bin/bash
set -eax
if [[ "\$AUTO_UPDATE_VUETORRENT" == "true" ]]; then
  crond -b
fi;
exec "\$@"
EOT
COPY <<EOT /usr/bin/update-vuetorrent
#!/bin/bash
set -eax
git pull
EOT
COPY <<EOT /etc/crontabs/qb
0 * * * * /usr/bin/update-vuetorrent
EOT
COPY <<EOF "${HOME}/.qb-default-config/qBittorrent.conf"
[BitTorrent]
Session\\Port=20394
Session\\QueueingSystemEnabled=false

[LegalNotice]
Accepted=true

[Meta]
MigrationVersion=6

[Network]
Cookies=@Invalid()

[Preferences]
WebUI\\AlternativeUIEnabled=true
WebUI\\RootFolder=${HOME}/vuetorrent
EOF
RUN apk --no-cache add git && chmod +x /usr/bin/update-vuetorrent-job /usr/bin/update-vuetorrent /etc/crontabs/qb
USER qb
RUN git clone --single-branch --branch latest-release https://github.com/VueTorrent/VueTorrent.git "${HOME}/vuetorrent"

CMD [ "/usr/bin/update-vuetorrent-job", "/usr/bin/qbittorrent-nox" ]
