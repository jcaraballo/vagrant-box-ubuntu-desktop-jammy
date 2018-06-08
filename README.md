# vagrant-box-ubuntu-desktop-bionic
Resources to create a Vagrant Base Box with an Ubuntu Desktop Bionic 18.04 LTS

## Requires

* [Vagrant](https://www.vagrantup.com/downloads.html)
```
wget https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_x86_64.deb
sudo dpkg -i vagrant_2.0.3_x86_64.deb
```

* [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)
```
echo deb http://download.virtualbox.org/virtualbox/debian $( lsb_release -cs ) contrib | sudo tee -a /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox-5.2 dkms
```

## Build
* _Host_: [Download Ubuntu Desktop 18.04 LTS (64 bit)](https://www.ubuntu.com/download/desktop)
  1. Memory size: 8192
  2. Create hard disk vdi, dynamically allocated with 30Gb
* _Guest_: Install Ubuntu in a VirtualBox VM, including the guest additions —see for example [these instructions](https://www.wikihow.com/Install-Ubuntu-on-VirtualBox)— with:
  1. Install directly
  2. Select _Download updates while installing Ubuntu_
  3. Select _Install third-party software_
  4. Leave selected _Erase disk and install Ubuntu_ (no encryption) and select _Use LVM with the new Ubuntu installation_
  5. Time zone London
  6. Keyboard layout English (UK)/English (UK)  
  7. User _vagrant_ with password _vagrant_. Hostname _vagrant_. Neither automatic log in nor home encryption.
  8. Once the installation is complete, reboot
  9. Install updates, reboot
  10. Install guest additions (used 5.2.12), reboot
  11. Clean up favourites to taste (docked quick launchers)

* _Guest_: Run [prepare-base-box-root.bash](prepare-base-box-root.bash) as root and [prepare-base-box-vagrant.bash](prepare-base-box-vagrant.bash) as the vagrant user
  ```
  wget https://raw.githubusercontent.com/jcaraballo/vagrant-box-ubuntu-desktop-xenial/master/prepare-base-box-root.bash -O - | sudo bash
  wget https://raw.githubusercontent.com/jcaraballo/vagrant-box-ubuntu-desktop-xenial/master/prepare-base-box-vagrant.bash -O - | bash
  ```
  Send the shutdown signal and turn off the VM

* _Host_:
  (Replace `VBOX_PATH` by the path to the Virtual Box VM `.vbox` file, usually inside `~/VirtualBox\ VMs/`)
  ```
  vagrant package --base VBOX_PATH --output package.box
  ```

* _Host_:
  (Add `-f` if you've already added the box to the vagrant list and want to
  replace it)
  ```
  vagrant box add --name ubuntu-desktop-xenial-18.04 package.box 
  ```


## Binary
[jcaraballo/ubuntu-desktop-bionic](https://app.vagrantup.com/jcaraballo/boxes/ubuntu-desktop-bionic)

## Usage example
See [vagrant-ubuntu-18.04-ovpn](https://github.com/jcaraballo/vagrant-ubuntu-18.04-ovpn)
