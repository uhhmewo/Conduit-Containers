FROM archlinux:latest

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