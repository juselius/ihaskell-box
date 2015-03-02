#!/bin/bash

# Installs Haskell stuff, a few prerequisites for it, and
# some tools, for Jonas' functional programming course.

# Prerequisites and some stuff we just do on a fresh Ubuntu
sudo apt-get update
sudo apt-get install -y language-pack-en


# Haskell installation, from instructions here:
#     http://www.stackage.org/install
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:hvr/ghc
sudo apt-get update
sudo apt-get install -y cabal-install-1.20 ghc-7.8.4
sudo apt-get install -y zlib1g-dev libzmq3-dev libtinfo-dev
sudo apt-get install -y git zsh pkgconf
sudo apt-get install -y ipython-notebook python-dev python-pip

# we need ipython notebook from the 2.x branch, not 1.x and not 3.x
sudo pip install --upgrade "ipython==2.3.0"
sudo pip install --upgrade tornado
sudo pip install --upgrade jsonschema

cat >> ~/.bashrc <<EOF
export PATH=/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:~/.cabal/bin:$PATH
EOF
export PATH=/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:~/.cabal/bin:$PATH
cabal update
cabal install alex happy

# Further installation instructions from Jonas' mail
cd /tmp
curl -o cabal.config http://www.stackage.org/snapshot/nightly-2015-02-24/cabal.config?global=true
cat cabal.config ~/.cabal/config > /tmp/cabal.config-new
mv /tmp/cabal.config-new ~/.cabal/config
rm -f cabal.config*

cabal update
cabal install cabal-install
cabal install alex happy
cabal install cpphs hscolour hlint haddock

git clone https://github.com/juselius/IHaskell.git
cd IHaskell
./build.sh
cd ~
rm -rf /tmp/IHaskell

cd ~
git clone https://github.com/juselius/dotfiles.git .dotfiles
cd ~/.dotfiles
./bin/install-dotfiles.sh

# autostart the haskell lessons on a "public" ip
cd ~
IHaskell notebook &
p=$!
sleep 15
kill -HUP $p

if [ ~/.ipython/profile_haskell/ipython_notebook_config.py ]; then
    echo 'c.NotebookApp.ip = "0.0.0.0"' >> \
        ~/.ipython/profile_haskell/ipython_notebook_config.py
fi

git clone https://github.com/juselius/haskell-intro.git
cat << EOF > ~/run_haskell_intro.sh
#!/bin/bash
cd ~/haskell-intro
git reset --hard HEAD
git pull
~/.cabal/bin/IHaskell notebook -s .
EOF
chmod 755 ~/run_haskell_intro.sh

# make upstart job for run_haskell_intro
cat << EOF > /tmp/haskell_intro.conf
description "Jonas' Haskell intro"
start on runlevel [2345]
stop on runlevel [06]
respawn
exec /bin/su vagrant /home/vagrant/run_haskell_intro.sh
EOF
sudo mv /tmp/haskell_intro.conf /etc/init/
