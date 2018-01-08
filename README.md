# vagrant-box-ubuntu-desktop-xenial
Resources to create a Vagrant Base Box with an Ubuntu Desktop Xenial 16.04.3 LTS

## Requires

* [Vagrant](https://www.vagrantup.com/downloads.html)
```
wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb
sudo dpkg -i vagrant_2.0.1_x86_64.deb
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
* _Guest_: Install Ubuntu Desktop Xenial 16.04.3 LTS in a VirtualBox VM, including the guest additions —see for example [these instructions](https://www.wikihow.com/Install-Ubuntu-on-VirtualBox)— with:
  1. Install directly
  2. Select _Download updates while installing Ubuntu_
  3. Select _Install third-party software_
  4. Leave selected _Erase disk and install Ubuntu_ (no encryption)
  5. Time zone London
  6. Keyboard layout English (UK)/English (UK)  
  7. User _vagrant_ with password _vagrant_. Hostname _vagrant_. Neither automatic log in nor home encryption.
  8. Reboot
  9. Install guest additions

* _Guest_: Run [prepare-base-box-root.bash](prepare-base-box-root.bash) as root and [prepare-base-box-vagrant.bash](prepare-base-box-vagrant.bash) as the vagrant user
  ```
  wget https://raw.githubusercontent.com/jcaraballo/vagrant-box-ubuntu-desktop-xenial/master/prepare-base-box-root.bash -O - | sudo bash
  wget https://raw.githubusercontent.com/jcaraballo/vagrant-box-ubuntu-desktop-xenial/master/prepare-base-box-vagrant.bash -O - | bash
  ```

* _Host_:
  (Replace `VBOX_PATH` by the path to the Virtual Box VM `.vbox` file, usually inside `~/VirtualBox\ VMs/`)
  ```
  vagrant package --base VBOX_PATH --output package.box
  ```

* _Host_:
  (Add `-f` if you've already added the box to the vagrant list and want to
  replace it)
  ```
  vagrant box add --name ubuntu-desktop-xenial-16.04.3 package.box 
  ```


## Binary
[jcaraballo/ubuntu-desktop-xenial](https://app.vagrantup.com/jcaraballo/boxes/ubuntu-desktop-xenial)

## Usage example
See [vagrant-ubuntu-16.04-ovpn](https://github.com/jcaraballo/vagrant-ubuntu-16.04-ovpn)
