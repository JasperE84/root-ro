#/bin/sh
rm /disable-root-ro
systemctl stop systemd-random-seed.service
if [ -f /var/lib/systemd/random-seed ]; then
  rm -f /var/lib/systemd/random-seed
fi
reboot
