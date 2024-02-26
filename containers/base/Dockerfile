FROM 3xpo/minimal-omz

LABEL org.opencontainers.image.title="Expo's Arch Linux Base Image"
LABEL org.opencontainers.image.description="Preset Containerd image of Arch Linux with a general decent baseline node build environment. Based on 3xpo/minimal-omz."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/base/README.md"

# Setup pnpm's environment
ENV PNPM_HOME=/home/astolfo/.local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH
RUN <<EOT
  mkdir -p $PNPM_HOME
  chown -R astolfo:astolfo $PNPM_HOME
  chmod -R 755 $PNPM_HOME
EOT

# Set up pnpm's zshrc
RUN <<EOT
echo -e "# pnpm\nexport PNPM_HOME=\"/home/astolfo/.local/share/pnpm\"\ncase \":\$PATH:\" in\n  *\":\$PNPM_HOME:\"*) ;;\n  *) export PATH=\"\$PNPM_HOME:\$PATH\" ;;\nesac\n# pnpm end" > $HOME/.pnpm-load
cat .pnpm-load >> .zshrc
# in future, we might wanna add a check for other .rc files
rm .pnpm-load
EOT

# Install pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | ENV="$HOME/.zshrc" zsh -

# Set up node from pnpm
RUN pnpm env use latest -g

# Install npm
RUN pnpm install -g npm
