FROM docker.io/3xpo/minimal-omz

LABEL org.opencontainers.image.title="Expo's Prometheus Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with prometheus preinstalled."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/containers/ci/prometheus/README.md"

ENV PROMETHEUS_INSTALL="${HOME}/Prometheus"
RUN sudo pacman -Syu --noconfirm --needed luajit git neovim nano
RUN git clone "https://github.com/prometheus-lua/Prometheus.git" "${PROMETHEUS_INSTALL}"
COPY <<EOT /bin/prometheus
#!/usr/bin/env bash
luajit "${PROMETHEUS_INSTALL}/cli.lua" \$@;
exit \$?
EOT
RUN sudo chmod +x /bin/prometheus
RUN sudo mkdir -p /scripts
VOLUME [ "/scripts" ]
CMD ["/bin/prometheus","--preset","Medium","/scripts/script.lua"]
