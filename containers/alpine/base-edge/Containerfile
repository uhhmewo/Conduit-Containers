FROM docker.io/alpine:edge AS base

RUN sh -c 'apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add nano shadow sudo && \
  useradd lain && \
  (mkhomedir_helper lain || true)'
COPY <<EOF /etc/sudoers.d/lain
lain ALL=(ALL:ALL) NOPASSWD: ALL
EOF

FROM scratch

LABEL org.opencontainers.image.title="Expo's Prometheus Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Alpine Linux Edge."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/containers/alpine/base-edge/README.md"

COPY --from=base / /
USER lain
ENV HOME="/home/lain"
ENV USER="lain"
CMD [ "sh" ]
