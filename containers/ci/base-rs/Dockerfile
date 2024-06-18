FROM 3xpo/base

LABEL org.opencontainers.image.title="Expo's Arch Linux Base Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with a general decent baseline rust build environment. Based on 3xpo/base, ships with stable-x86_64-unknown-linux-(musl|gnu), stable-x86_64-pc-windows-gnu."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/containers/ci/base-rs/README.md"
LABEL org.opencontainers.image.licenses="GPL-3.0-or-later"

# Install Rust
RUN sudo pacman -Syu --noconfirm --needed rustup

# Setup rust toolchains
RUN <<EOT
#!/usr/bin/zsh

# Install toolchains
rustup toolchain install stable-x86_64-unknown-linux-gnu &
rustup toolchain install stable-x86_64-unknown-linux-musl &
rustup toolchain install stable-x86_64-pc-windows-gnu &

# Wait for toolchains to install
wait

# Install stable for wherever you're currently running
rustup toolchain install stable

# Set default toolchain
rustup default stable
EOT
