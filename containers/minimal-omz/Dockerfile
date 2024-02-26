FROM 3xpo/minimal

LABEL org.opencontainers.image.title="Expo's Arch Linux Minimal Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with minimal packages installed, without being unusably minimal. Includes OMZ."
LABEL org.opencontainers.image.authors="Expo <expo.containers@breadhub.cc>"
LABEL org.opencontainers.image.url="https://codeberg.org/Expo/containers"
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/minimal-omz/README.md"
LABEL org.opencontainers.image.source="https://codeberg.org/Expo/containers"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
#CI:INSERT_VERSION_LABEL
#CI:INSERT_REVISION_LABEL
#CI:INSERT_CREATION_LABEL

# Install omz
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
