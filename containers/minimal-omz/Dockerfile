FROM 3xpo/minimal

LABEL org.opencontainers.image.title="Expo's Arch Linux Minimal Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with minimal packages installed, without being unusably minimal. Includes OMZ."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/minimal-omz/README.md"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"

# Install omz
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
