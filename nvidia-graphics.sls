# I used to have steps for nvidia proprietary drivers but I ran into issues so I decided to stick with the Nouveau drivers.
# If I find issues with this in the future I will look into changing to use proprietary drivers from the rpmfusion repos.
#
# with further research it seems that the bumblebee-nouveau was not playing nice with gnome and `cat /sys/kernel/debug/vgaswitcheroo/switch` reports that the nvidia card to 'DynOff' if I don't have an external monitor plugged in to it. Since that will be fine for most of the time I am going to leave it alone for now and come back to this when I have more need of my graphics card.

bumblebee_repo:
  pkg.installed:
    - sources:
      - bumblebee_dnf: http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee/fedora23/noarch/bumblebee-release-1.2-1.noarch.rpm


install_bumblebee_packages:
  pkg.installed:
    - pkgs:
      - bumblebee-nouveau
      - bbswitch-dkms
      - kernel-devel
    
