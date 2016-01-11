#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

cp -aT /etc/skel/ /root/
chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

rm /usr/share/applications/assistant.desktop
rm /usr/share/applications/assistant-qt4.desktop
rm /usr/share/applications/bssh.desktop
rm /usr/share/applications/bvnc.desktop
rm /usr/share/applications/cups.desktop
rm /usr/share/applications/designer.desktop
rm /usr/share/applications/designer-qt4.desktop
rm /usr/share/applications/elinks.desktop
rm /usr/share/applications/linguist.desktop
rm /usr/share/applications/linguist-qt4.desktop
rm /usr/share/applications/qdbusviewer.desktop
rm /usr/share/applications/qdbusviewer-qt4.desktop
rm /usr/share/applications/qtconfig-qt4.desktop
rm /usr/share/applications/qv4l2.desktop
rm /usr/share/applications/tracker-needle.desktop
rm /usr/share/applications/tracker-preferences.desktop
rm /usr/share/applications/zenmap.desktop
rm /usr/share/applications/zenmap-root.desktop

glib-compile-schemas /usr/share/glib-2.0/schemas/

systemctl enable pacman-init.service choose-mirror.service
systemctl enable gdm.service
systemctl enable NetworkManager.service
systemctl enable org.cups.cupsd.service
