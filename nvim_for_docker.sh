#!/bin/sh

# docker内でnvimを使うためのスクリプト
# apt でインストールを行うディストリビューション前提

#   nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage 
./nvim.appimage --appimage-extract 
./squashfs-root/AppRun --version 
sudo mv squashfs-root / 
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim 

sudo apt install -y ripgrep git

# 設定ファイルの取得
git clone https://github.com/tomotaka-kato/nvim.git ~/.config/nvim

# pacakerのインストール
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
