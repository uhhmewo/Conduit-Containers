FROM docker.io/alpine:edge AS base

RUN sh -c 'apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add nano shadow sudo && \
  useradd astolfo && \
  (mkhomedir_helper astolfo || true)'
COPY <<EOT /etc/sudoers.d/astolfo
root ALL=(ALL:ALL) NOPASSWD: ALL
EOT

FROM scratch

LABEL org.opencontainers.image.title="Expo's Prometheus Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Alpine Linux Edge."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/containers/alpine/base-edge/README.md"

COPY --from=base / /
USER alpine
