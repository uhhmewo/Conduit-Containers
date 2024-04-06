FROM 3xpo/minimal-omz

LABEL org.opencontainers.image.title="Expo's Arch Linux ROCm-Torch Image"
LABEL org.opencontainers.image.description="Preset Containerd image for ROCm. Based on 3xpo/base."
LABEL org.opencontainers.image.documentation="https://codeberg.org/Expo/containers/src/branch/master/base/README.md"

ENV PATH=$PATH:$HOME/.local/bin:/opt/rocm/bin

RUN <<EOT
  set -eax

  # Setup Python
  sudo pacman -Syu python python-pip --needed --noconfirm

  # Install ROCm Stuff
  sudo pacman -S rocminfo --needed --noconfirm
  
  # Remove the "Externally Managed" crap
  sudo rm -rf /usr/lib/python*/EXTERNALLY-MANAGED

  # Install Torch
  pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/rocm6.0
EOT

ONBUILD RUN sudo pacman -Syu
