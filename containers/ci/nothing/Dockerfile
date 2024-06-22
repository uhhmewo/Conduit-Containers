FROM docker.io/archlinux:latest AS base

# Upgrade System
RUN pacman -Syu --noconfirm

# Install pacman-contrib for cache clearing
RUN pacman -S --noconfirm --needed pacman-contrib

# Remove any unneeded packages
RUN pacman -Rns --noconfirm `pacman -Qdtq`

# Clear package cache
RUN paccache -r -k 0

# Remove pacman-contrib - pacman-contrib will stay in the cache until the next step
RUN pacman -Rns --noconfirm pacman-contrib

# Remove pacman-contrib from the cache
RUN rm -rf /var/cache/pacman/pkg/pacman-contrib-*

# Create a flattened image from all of the above
FROM scratch
COPY --from=base / /

# Set up metadata
LABEL org.opencontainers.image.title="Expo's Arch Linux Nothing Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with as few packages as humanly possible installed."
LABEL org.opencontainers.image.authors="Expo <expo.containers@breadhub.cc>"
LABEL org.opencontainers.image.url="https://codeberg.org/Expo/containers"
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/containers/ci/nothing/README.md"
LABEL org.opencontainers.image.source="https://codeberg.org/Expo/containers"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
#CI:INSERT_VERSION_LABEL
#CI:INSERT_REVISION_LABEL
#CI:INSERT_CREATION_LABEL
# CI will insert the version in the above placeholders for us - this will look something like:
# LABEL org.opencontainers.image.version="1.0.20240226-11-55"
# LABEL org.opencontainers.image.revision="e90cb0a7bdce096b52e08478ecef8ef66862bc6a"
# LABEL org.opencontainers.image.created="2024-02-26T11:55:00Z"

# Set the default SHELL
SHELL ["/usr/bin/sh", "-c"]
ENV SHELL="/usr/bin/sh"

# Set the default CMD
CMD ["/usr/bin/sh"]
