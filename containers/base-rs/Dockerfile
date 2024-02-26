FROM 3xpo/base

# Install Rust
RUN sudo pacman -Syu --noconfirm --needed rustup

# Setup rust toolchains
RUN <<EOT
#!/usr/bin/zsh

# Install toolchains
rustup toolchain install stable-x86_64-unknown-linux-gnu
rustup toolchain install stable-x86_64-unknown-linux-musl
rustup toolchain install stable-x86_64-unknown-windows-gnu

# Set default toolchain
rustup default x86_64-unknown-linux-musl
EOT
