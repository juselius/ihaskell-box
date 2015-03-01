# Vagrant VM for Jonas' functional programming course

Vagrantfile and provisioning script for a virtual machine that has all the
Haskell stuff you need for the course.

A build of the VM can be found at [https://github.com/juselius/ihaskell-box](https://github.com/juselius/ihaskell-box).

## Quickstart

Have git, VirtualBox and Vagrant installed. All are quick and easy to install
on Linux, Mac, or Windows boxes.

Then:

    git clone git@source.uit.no:lars.tiede/haskell_vm.git
    cd haskell_vm
    vagrant up

Then wait for vagrant to build the VM. This will take a while. Then:

    vagrant ssh

Now you are logged into the VM. The directory you called "vagrant up" from
(i.e. the directory where you cloned this repository to) is mapped into the
VM at /vagrant. You can edit files on your host OS and then compile/run them
in the VM, or you can install your favorite editor in the VM. You're good to
go!


## Quickstop

"vagrant suspend" / "vagrant resume" suspends/resumes your VM. With "vagrant
halt" you can shut down the VM, and with "vagrant up" you cn start it again.
Just run
"vagrant" without arguments to see what else you can do.

To tear down the VM and everything in it (but not the shared directory of
course), run this:

    vagrant destroy
