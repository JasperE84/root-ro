#!/bin/sh

# Error out if anything fails.
set -e

# Make sure script is run as root.
if [ "$(id -u)" != "0" ]; then
  echo "Must be run as root with sudo! Try: sudo ./install.sh"
  exit 1
fi

echo Creating initramfs...
mkinitramfs -o /boot/init.gz

if ! grep -q "^initramfs " /boot/config.txt; then
  echo Adding \"initramfs init.gz\" to /boot/config.txt
  echo initramfs init.gz >> /boot/config.txt
fi

if ! grep -q "^overlay" /etc/initramfs-tools/modules; then
  echo Adding \"overlay\" to /etc/initramfs-tools/modules
  echo overlay >> /etc/initramfs-tools/modules
fi



if dpkg --get-selections | grep -q "^dphys-swapfle\s*install$" >/dev/null; then
    echo Disabling swap, we dont want swap files in a read-only root filesystem...
    dphys-swapfile swapoff
    dphys-swapfile uninstall
    update-rc.d dphys-swapfile disable
    systemctl disable dphys-swapfile
else
    echo dphys-swapfile is not installed, assuming we dont need to disable swap
fi

echo Setting up maintenance scripts in /root...
cp reboot-to-readonly-mode.sh /root/reboot-to-readonly-mode.sh
chmod +x /root/reboot-to-readonly-mode.sh

cp reboot-to-writable-mode.sh /root/reboot-to-writable-mode.sh
chmod +x /root/reboot-to-writable-mode.sh

echo Setting up initramfs-tools scripts...
cp etc/initramfs-tools/scripts/init-bottom/root-ro /etc/initramfs-tools/scripts/init-bottom/root-ro
chmod +x /etc/initramfs-tools/scripts/init-bottom/root-ro

cp etc/initramfs-tools/hooks/root-ro /etc/initramfs-tools/hooks/root-ro
chmod +x /etc/initramfs-tools/hooks/root-ro

echo Updating initramfs...
update-initramfs -u
mkinitramfs -o /boot/init.gz

if ! grep -q "root-ro-driver=overlay" /boot/cmdline.txt; then
  echo Adding root-ro-driver parameter to /boot/cmdline.txt
  sed -i "1 s|$| root-ro-driver=overlay|" /boot/cmdline.txt
fi

echo Removing the random seed file
systemctl stop systemd-random-seed.service
if [ -f /var/lib/systemd/random-seed ]; then
  rm -f /var/lib/systemd/random-seed
fi

# Restarting without warning seems a bit harsh, so we'll just inform that it's necessary
# reboot
echo Please restart your RPI now to boot into read-only mode
