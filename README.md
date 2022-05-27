# vagrant-box-ubuntu-desktop-jammy
Resources to create a Vagrant Base Box with an Ubuntu Desktop 22.04 LTS (Jammy Jellyfish)

## Requires

* [Vagrant](https://www.vagrantup.com/downloads.html)
```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vagrant
```

* [VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)
```
echo deb '[arch=amd64]' http://download.virtualbox.org/virtualbox/debian $( lsb_release -cs ) contrib | sudo tee -a /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox-6.1 dkms
```

* VirtualBox Guest Additions (6.1.26)
```
wget https://download.virtualbox.org/virtualbox/6.1.26/Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.26.vbox-extpack
```

## Build
* _Host_: Download [Ubuntu 22.04 LTS (64 bit)](https://www.ubuntu.com/download/desktop)
* _Host_: Create a new Virtual Box VM for the installation
  1. Open VM Virtual Box Manager
  2. Click New
  3. Virtual machine general details:
     1. Name: Ubuntu Desktop 22.04 LTS (Jammy Jellyfish)
     2. Type: Linux
     3. Version: Ubuntu (64-bit)
  4. Memory size: 8192
  5. Hard disk:
     1. Create a virtual hard disk now
     2. VDI
     3. Dinamically allocated
     4. 50 Gb
  6. Open the settings of the VM > Display > Increase video memory to 128 MB
     (for some reason with the default video memory the keyboard doesn't get captured
     by the guest)
  7. Start the new VM: Doble click on the newly created VM with the name given above
  8. Add an optical drive, select the image downloaded from Ubuntu and click start
* _Guest_: Install Ubuntu in a VirtualBox VM, including the guest additions:
  1. Select _Install Ubuntu_
  2. Keyboard layout English (UK)/English (UK)  
  3. Minimal installation
  4. Leave _Download updates while installing Ubuntu_ selected
  5. Select _Install third-party software_
  6. Leave selected _Erase disk and install Ubuntu_
  7. Select Advanced Features and _Use LVM with the new Ubuntu installation_, but leave Encrypt the new Ubuntu installation for security unselected.
  8. Time zone London
  9. User _vagrant_ with password _vagrant_. Hostname _vagrant_. Require password to log in.
  10. Once the installation is complete, reboot
  11. Install updates, reboot
  12. Install guest additions dependencies
      ```
      sudo apt install gcc make perl
      ```
  13. Install guest additions, eject the additions media and reboot

* _Guest_: Run some scripts to make the image Vagrant-friendly
  1. Run [prepare-base-box-root.bash](prepare-base-box-root.bash) as root (requires password for sudo)
  ```
  wget https://raw.githubusercontent.com/jcaraballo/vagrant-box-ubuntu-desktop-jammy/master/prepare-base-box-root.bash -O - | sudo bash
  ```
  2. Run [prepare-base-box-vagrant.bash](prepare-base-box-vagrant.bash) as the vagrant user
  ```
  wget https://raw.githubusercontent.com/jcaraballo/vagrant-box-ubuntu-desktop-jammy/master/prepare-base-box-vagrant.bash -O - | bash
  ```
  3. Send the shutdown signal and turn off the VM

* _Host_:
  (Replace `VBOX_PATH` by the path to the Virtual Box VM `.vbox` file, usually inside `~/VirtualBox\ VMs/`)
  ```
  vagrant package --base VBOX_PATH --output package.box
  ```

* _Host_:
  (Add `-f` if you've already added the box to the vagrant list and want to
  replace it)
  ```
  vagrant box add --name ubuntu-desktop-jammy-22.04 package.box
  ```

* (Optional) If you'd like to upload it to vagrantup
  1. Create a new account if you don't already have one and log in
  2. New Vagrant Box
  3. Add name and description. I use
    1. Name: `jcaraballo` / `ubuntu-desktop-jammy`
    2. Description:
       ```
       Vagrant/VirtualBox Base Box with an Ubuntu Desktop 22.04 LTS (Jammy Jellyfish)
       * Project sources: REPO_LINK
       * For this version: VERSION_LINK
       ```
       (Replace `REPO_LINK` by a link to the repo and `VERSION_LINK` by a permanent
       link to the specific version, e.g. in Github select the commit and click
       on _browes files_)
  4. Version, e.g. 0.0.1
  5. Add a provider
     1. virtualbox
     2. Upload to Vagrant Cloud
  6. Choose file: select file `package.box` generated earlier with `vagrant package`
  7. Back to the dashboard, select the created box
  8. On the appropriate version: Release > Release version


## Binary
[Vagrant Cloud: jcaraballo/ubuntu-desktop-jammy](https://app.vagrantup.com/jcaraballo/boxes/ubuntu-desktop-jammy)

## Usage example
See [vagrant-ubuntu-22.04-dev](https://github.com/jcaraballo/vagrant-ubuntu-22.04-dev)
