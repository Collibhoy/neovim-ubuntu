!#/bin/bash

mkdir ~/.config/nvim
cp init.vim ~/.config/nvim

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable

sudo apt-get update
sudo apt-get install python-dev python-pip python3-dev python3-pip

sudo apt-get install neovim
pip3 install neovim

sudo apt-install curl
sudo apt-install git

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall