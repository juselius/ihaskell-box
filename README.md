# IHaskell Vagrant box

## Prerequisites

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

## Install
```shell
$ git clone https://github.com/juselius/ihaskell-box.git
$ cd ihaskell-box
$ vagrant up
```
## Usage

#### Linux
    $ xdg-open http://localhost:8778

#### MacOS
    $ open http://localhost:8778

#### Windows
    C:\> notthefaintestidea.exe

### Connecting to the VM
    $ vagrant ssh

### Shutting down
    $ vagrant halt

### Removing the VM
    $ vagrant destroy
    $ vagrant box remove ihaskell

