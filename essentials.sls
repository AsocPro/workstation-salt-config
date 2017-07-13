{% from 'paths.jinja' import user_path, admin_group %}
{% from 'paths.jinja' import colehack %}

{% set mainUser = 'superuser' %}


{{ user_path }}/{{ mainUser }}/.gitconfig:
  file.managed:
    - source: salt://files/configs/gitconfig
    - user: {{ mainUser }}
    - template: jinja

{{ user_path }}/{{ mainUser }}/.resources:
  file.directory:
    - user: {{ mainUser }}

{{ user_path }}/{{ mainUser }}/.vimrc:
  file.managed:
    - source: salt://files/configs/vimrc
    - user: {{ mainUser }}

get_pathogen_vim:
  git.latest:
    - name: https://github.com/tpope/vim-pathogen.git
    - target: {{ user_path }}/{{ mainUser }}/.resources/pathogen

{{ user_path }}/{{ mainUser }}/.vim/autoload/pathogen.vim:
  file.symlink:
    - target: {{ user_path }}/{{ mainUser }}/.resources/pathogen/autoload/pathogen.vim
    - user: {{ mainUser }}
    - makedirs: True

{{ user_path }}/{{ mainUser }}/.vim/bundle:
  file.directory:
    - user: {{ mainUser }}

get_salt_vim:
  git.latest:
    - name: https://github.com/saltstack/salt-vim.git
    - target: {{ user_path }}/{{ mainUser }}/.vim/bundle/salt-vim
    
{{ colehack.path }}:
  {{ colehack.function }}:
    - source: salt://files/keyboard-layouts/{{ colehack.name }}
    - user: root
    - group: {{ admin_group }}
    - dir_mode: 755
    - file_mode: 644

{% if grains.get('os_family') == 'linux' %}
/etc/vpnc/default.conf:
  file.managed:
    - source: salt://files/configs/vpnc.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
{%- endif -%}
