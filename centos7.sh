#!/bin/bash
#install mirror: http://mirrors.aliyun.com/centos/7/os/x86_64/

# set [priority=1] to official repository
sed -i -e "s/\]$/\]\npriority=1/g" /etc/yum.repos.d/CentOS-Base.repo

#Install a plugin to add priorities to each installed repositories.
yum -y install yum-plugin-priorities

# Add EPEL Repository which is provided from Fedora project
yum -y install epel-release
# set [priority=5]
sed -i -e "s/\]$/\]\npriority=5/g" /etc/yum.repos.d/epel.repo

cat <<'EOF'>> /etc/yum/pluginconf.d/fastestmirror.conf
include_only=.com.cn,.cn,.net.cn,.edu.cn,.org.cn,.163.com,.aliyun.com
EOF

## Application Installation ##

## Basic ##
# Install Server with GUI group applications.
#yum -y groups install "Server with GUI"

# install Xfce from EPEL
yum -y group install "X Window System"
yum --enablerepo=epel -y groups install "Xfce"
#Install NTFS support and Cifs support
yum -y install ntfs-3g cifs-utils gvfs
yum -y install gcc
yum -y install openssl-perl
yum -y install network-manager-applet
yum -y install bash-completion bash-completion-extras

#install other tools
yum -y install thunar-archive-plugin xarchiver bzip2 wget firefox evince gvfs-mtp eog gedit xscreensaver alsa-utils alsa-lib-devel alsa-firmware alsa-plugins-pulseaudio alsa-lib alsa-tools-firmware unzip python3 xfce4-screenshooter tcping

ln -s /usr/libexec/thunar-archive-plugin/file-roller.tap /usr/libexec/thunar-archive-plugin/org.gnome.FileRoller.tap

# to support Android phone file system
yum install -y fuse jmtpfs libmtp

#To better switch between different display profile, use tool autorandr
#https://github.com/phillipberndt/autorandr
pip3 install autorandr

# Install ImageMagick which can be used for Image to PDF convert
yum install ImageMagick -y

# Chinese support
yum group install fonts -y
yum install ibus-libpinyin -y
# add ibus-daemon to autostart

# office
yum install -y libreoffice
