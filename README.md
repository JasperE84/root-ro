roo-ro
======
This repository contains some useful files that allow me to use my raspberry pi with a readonly file system.

This files contains some ideas and code of the following projects:
- https://gist.github.com/niun/34c945d70753fc9e2cc7
- https://github.com/chesty/overlayroot

Congratulate the original authors if these files works as expected. Too, you can congratulate to me to join all files in a one repository.

Setup
=====
To use this code, you can execute the follow commands:

```
cd /home/pi
git clone https://github.com/josepsanzcamp/root-ro.git
sudo bash
rsync -va root-ro/etc/initramfs-tools/* /etc/initramfs-tools/
mkinitramfs -o /boot/initrd.gz
echo initramfs initrd.gz >> /boot/config.txt
reboot
```

