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
apt-get -y install git
cd /home/pi
git clone https://github.com/JasperE84/root-ro.git
cd root-ro
chmod +x install.sh
sudo ./install.sh
```

Rebooting to permanent write-mode (disabling the overlay fs)
============
Execute 
```
sudo /root/reboot-to-writable-mode.sh
```

Rebooting to permanent read-only mode (enabling the overlay fs)
============
Execute 
```
sudo /root/reboot-to-readonly-mode.sh
```

Enabling temporary write access mode:
============
Write access can be enabled using following command.
```
sudo mount -o remount,rw /mnt/root-ro
chroot /mnt/root-ro
```


Exiting temporary write access mode:
===============
Exit the chroot and re-mounting the filesystem:
```
eit
sudo mount -o remount,ro /mnt/root-ro
```

Original state
==============
To return to the original state to allow easy apt-get update/upgrade and rpi-update, you need to add a comment mark to the "initramfs initrd.gz" line to the /boot/config.txt file.
