#/bin/sh
mount -o remount,rw /mnt/root-ro
touch /mnt/root-ro/disable-root-ro
reboot
