
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

/etc/vpnc/default.conf:
  file.managed:
    - source: salt://files/configs/vpnc.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
