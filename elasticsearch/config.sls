# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_config:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://elasticsearch/files/elasticsearch.yml.j2
    - template: jinja
    - mode: 0660
    - user: root
    - group: elasticsearch
    - watch_in:
      - service: elasticsearch_service
   
{% if grains.os_family == "Debian" %}
elasticsearch_config_debian_defaults:
  file.managed:
    - name: /etc/default/elasticsearch
    - source: salt://elasticsearch/files/default-elasticsearch.j2
    - template: jinja
    - user: root
    - group: elasticsearch
    - mode: 0660
    - watch_in:
      - service: elasticsearch_service
{% endif %}

elasticsearch_jvm_options:
  file.managed:
    - name: /etc/elasticsearch/jvm.options
    - source: salt://elasticsearch/files/jvm_options.j2
    - template: jinja
    - mode: 0660
    - user: root
    - group: elasticsearch
    - watch_in:
      - service: elasticsearch_service

elasticsearch_log4j2_properties:
  file.managed:
    - name: /etc/elasticsearch/log4j2.properties
    - source: salt://elasticsearch/files/log4j2_properties.j2
    - template: jinja
    - mode: 0660
    - user: root
    - group: elasticsearch
    - watch_in:
      - service: elasticsearch_service

{% if elasticsearch.users is defined %}
elasticsearch_x-pack_users:
  file.managed:
    - name: /etc/elasticsearch/users
    - source: salt://elasticsearch/files/users.j2
    - template: jinja
    - mode: 0640
    - user: root
    - group: elasticsearch
    - es_users: {{ elasticsearch.users }}

elasticsearch_x-pack_user_roles:
  file.managed:
    - name: /etc/elasticsearch/users_roles
    - source: salt://elasticsearch/files/users_roles.j2
    - template: jinja
    - mode: 0640
    - user: root
    - group: elasticsearch
    - es_users: {{ elasticsearch.users }}
    - es_roles: {{ elasticsearch.roles }}

{% endif %}

# TODO: gen then export to salt mine?
elasticsearch_x-pack_system_key:
  file.managed:
    - name: /etc/elasticsearch/system_key
    - source: salt://elasticsearch/files/system_key
    - mode: 0640
    - user: root
    - group: elasticsearch
    - watch_in:
      - service: elasticsearch_service

{% if elasticsearch.roles_custom is defined %}
elasticsearch_x-pack_roles:
  file.managed:
    - name: /etc/elasticsearch/roles.yml
    - source: salt://elasticsearch/files/roles.yml.j2
    - mode: 0640
    - user: root
    - group: elasticsearch
    - template: jinja
    - backup: 'minion'
    - roles_custom: {{ elasticsearch.roles_custom | yaml }}
{% endif %}
