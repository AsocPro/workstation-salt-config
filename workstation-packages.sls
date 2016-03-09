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

/home/{{ pillar['mainUser'] }}/.gitconfig:
  file.managed:
    - source: salt://files/configs/gitconfig
    - user: {{ pillar['mainUser'] }}
    - template: jinja
    
