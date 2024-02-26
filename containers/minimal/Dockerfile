FROM archlinux:latest

LABEL org.opencontainers.image.title="Expo's Arch Linux Minimal Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with minimal packages installed, without being unusably minimal."
LABEL org.opencontainers.image.authors="Expo <expo.containers@breadhub.cc>"
LABEL org.opencontainers.image.url="https://codeberg.org/Expo/containers"
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/minimal/README.md"
LABEL org.opencontainers.image.source="https://codeberg.org/Expo/containers"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"
#CI:INSERT_VERSION_LABEL
#CI:INSERT_REVISION_LABEL
#CI:INSERT_CREATION_LABEL
# CI will insert the version in the above placeholders for us - this will look something like:
# LABEL org.opencontainers.image.version="1.0.20240226-11-55"
# LABEL org.opencontainers.image.revision="e90cb0a7bdce096b52e08478ecef8ef66862bc6a"
# LABEL org.opencontainers.image.created="2024-02-26T11:55:00Z"

# Install base packages
RUN pacman -Syu --noconfirm --needed base base-devel zsh git openssh sudo curl

# Set up user
RUN useradd -m -G wheel -s /usr/bin/zsh astolfo && \
  echo "astolfo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/astolfo && \
  chmod 0440 /etc/sudoers.d/astolfo && \
  echo "astolfo:astolfo" | chpasswd && \
  mkhomedir_helper astolfo

# Set up user environment
USER astolfo
WORKDIR /home/astolfo

# Set the default SHELL
SHELL ["/usr/bin/zsh", "-c"]
ENV SHELL="/usr/bin/zsh"

# Set the default CMD
CMD ["/usr/bin/zsh"]
