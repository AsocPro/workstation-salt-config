##Manual steps.

#This wasnt working so I installed rpmfusion drivers but as that broke terribly as well I am trying to reinstall to fix it.
#
#Use this state with caution.
#
#This state does not run itself just so that there are not issues with some critical things.

# First you will need to append 'rd.driver.blacklist=noveau' to the end of 'GRUB_CMDLINE_LINUX=' line in /etc/sysconfig/grub.
# This line needs to be modified before you run this state in order for the grub2-mkconfig script to work correctly.
# This is until I think of the best way to work nicely with this file.
# After doing this then you run the state

# After the state is successful then you will need to do the following steps

# Backup the old initramfs noveau image
# mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

# Create new initramfs image
# dracut /boot/initramfs-$(uname -r).img $(uname -r)

# Then boot to runlevel 3 with 
# systemctl set-default multi-user.target
# reboot

# As root run the NVIDIA driver installer
# (if the state worked it should be in the mainUser home directory)

# After successful installation, reboot into runlevel 5
# systemctl set-default graphical.target
# reboot

# Then if you want VDPAU/VAAPI support you can run
# dnf install vdpauinfo libva-vdpau-driver libva-utils


#This link may go down so just be aware. You will have to install manually anyways.
/home/{{ pillar['mainUser'] }}/NVIDIA-Linux-x86_64-361.28.run:
  file.managed:
    - source: http://us.download.nvidia.com/XFree86/Linux-x86_64/361.28/NVIDIA-Linux-x86_64-361.28.run
    - source_hash: md5=16a583d074a83c1a3ef926e9c59d4349
    - mode: 755

include:
  - uptodate

install-needed-packages:
  pkg.installed:
    - pkgs:
      - kernel-devel
      - kernel-headers
      - gcc
      - dkms
      - acpid
      - akmod-nvidia

modprobe.d-blacklist-noveau:
  file.managed:
    - name: /etc/modprobe.d/nvidia.conf
    - source: salt://files/modprobe.d/nvidia.conf
    - user: root
    - group: root
    - mode: 644 

# This is the command for BIOS booting.
# If you use UEFI then it will be grub2-mkconfig -o /boot/efi/EFI/fedora.cfg
grub2-mkconfig:
  cmd.run:
    - name: grub2-mkconfig -o /boot/grub2/grub.cfg

xorg-x11-drv-noveau:
  pkg.removed
