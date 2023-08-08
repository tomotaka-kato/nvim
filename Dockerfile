FROM ubuntu:latest

# Create the user as docker
ARG USERNAME=docker
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

WORKDIR ~

# Install dependencies
RUN sudo apt-get update \
  && sudo apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    tar \
    gzip \
    ripgrep

# Install neovim
RUN cd ~ \
  && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
  && sudo chmod u+x nvim.appimage \
  && ./nvim.appimage --appimage-extract \
  && ./squashfs-root/AppRun --version \
  && sudo mv squashfs-root / \
  && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim \
  && sudo rm -rf ./nvim.appimage

# Install node for plugins
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - \
 && sudo apt-get install -y nodejs \
 && sudo npm install -g yarn neovim



