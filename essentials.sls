/home/superuser/.gitconfig:
  file.managed:
    - source: salt://files/configs/gitconfig
    - user: superuser
    - template: jinja

/home/superuser/.resources:
  file.directory:
    - user: superuser

/home/superuser/.vimrc:
  file.managed:
    - source: salt://files/configs/vimrc
    - user: superuser

get_pathogen_vim:
  git.latest:
    - name: https://github.com/tpope/vim-pathogen.git
    - target: /home/superuser/.resources/pathogen

/home/superuser/.vim/autoload/pathogen.vim:
  file.symlink:
    - target: /home/superuser/.resources/pathogen/autoload/pathogen.vim
    - user: superuser
    - makedirs: True

/home/superuser/.vim/bundle:
  file.directory:
    - user: superuser

get_salt_vim:
  git.latest:
    - name: https://github.com/saltstack/salt-vim.git
    - target: /home/superuser/.vim/bundle/salt-vim
    
/usr/share/X11/xkb/symbols/colehack:
  file.managed:
    - source: salt://files/keyboard-layouts/colehack
    - user: root
    - group: {{ admin_group }}
    - dir_mode: 755
    - file_mode: 644

/etc/vpnc/default.conf:
  file.managed:
    - source: salt://files/configs/vpnc.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
