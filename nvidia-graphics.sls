# I used to have steps for nvidia proprietary drivers but I ran into issues so I decided to stick with the Nouveau drivers.
# If I find issues with this in the future I will look into changing to use proprietary drivers from the rpmfusion repos.
#
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
    
