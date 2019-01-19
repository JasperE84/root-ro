Read-only Root-FS with overlayfs for Raspian Stretch
============================================
This repository contains some useful files that allow you to use a Raspberry PI using a readonly filesystem.

This files contains some ideas and code of the following projects:
- https://github.com/josepsanzcamp/root-ro
- https://gist.github.com/niun/34c945d70753fc9e2cc7
- https://github.com/chesty/overlayroot

Congratulate the original authors if these files works as expected. Too, you can congratulate to me to join all files in a one repository and do some changes allowing to use the root and boot filesytem in readonly mode.

Setup
=====
To use this code, you can execute the follow commands:

```
cd /home/pi
apt-get -y install git
git clone https://github.com/JasperE84/root-ro.git
cd root-ro
chmod +x install.sh
sudo ./install.sh
```

Write access
============
Write access can be enabled using following commands
```
# /
sudo mount -o remount,rw /mnt/root-ro
# /boot
sudo mount -o remount,rw /mnt/boot-ro
```

Read-only again
===============
Re-mounting it read-only is done using following commands
```
# /
sudo mount -o remount,ro /mnt/root-ro
# /boot
sudo mount -o remount,ro /mnt/boot-ro
```

Original state
==============
To return to the original state to allow easy apt-get update/upgrade and rpi-update, you need to add a comment mark to the "initramfs initrd.gz" line to the /boot/config.txt file.
