FROM 3xpo/base

LABEL org.opencontainers.image.title="Expo's Arch Linux Base Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with a general decent baseline flatpak build environment. Based on 3xpo/base."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/containers/ci/flatpak/README.md"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"

# Install Rust
RUN sudo pacman -Syu --noconfirm --needed flatpak flatpak-builder
