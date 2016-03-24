/etc/yum.repos.d/google-chrome.repo:
  file.managed:
    - source: salt://files/repos/google-chrome-yum.repo
    - user: root
    - group: root
    - mode: 644

install-packages:
  pkg.installed:
    - pkgs:
      - google-chrome-stable
      - vim-enhanced
      - arduino
      - ino
      - bsd-games
      - powertop
      - vpnc
      - htop
      - gitflow
      - nmap

/home/{{ pillar['mainUser'] }}/.gitconfig:
  file.managed:
    - source: salt://files/configs/gitconfig
    - user: {{ pillar['mainUser'] }}
    - template: jinja
    
/usr/share/X11/xkb/symbols/colehack:
  file.managed:
    - source: salt://files/keyboard-layouts/colehack.xkb
    - user: root
    - group: root
    - mode: 644

/home/{{ pillar['mainUser'] }}/.xsession:
  file.managed:
    - source: salt://files/configs/xsession
    - user: {{ pillar['mainUser'] }}

/etc/vpnc/default.conf:
  file.managed:
    - source: salt://files/configs/vpnc.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
