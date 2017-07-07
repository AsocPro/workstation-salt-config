{% from 'paths.jinja' import user_path, admin_group %}
{% from 'paths.jinja' import colehack %}

{{ user_path }}/{{ pillar['mainUser'] }}/.gitconfig:
  file.managed:
    - source: salt://files/configs/gitconfig
    - user: {{ pillar['mainUser'] }}
    - template: jinja
    
{{ colehack.path }}:
  {{ colehack.function }}:
    - source: salt://files/keyboard-layouts/{{ colehack.name }}
    - user: root
    - group: {{ admin_group }}
    - dir_mode: 755
    - file_mode: 644

{%- if grains.get('os_family') == 'linux' -%}
/etc/vpnc/default.conf:
  file.managed:
    - source: salt://files/configs/vpnc.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 600
{%- endif -%}
