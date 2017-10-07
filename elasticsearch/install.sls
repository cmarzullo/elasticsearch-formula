# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_install_dependencies:
  pkg.installed:
    - pkgs: {{ elasticsearch.dep_pkgs }}
    {% if elasticsearch.dep_fromrepo is defined %}
    - fromrepo: {{ elasticsearch.dep_fromrepo }}
    {% endif %}

elasticsearch_install_main_pkg:
  pkg.installed:
    - name: {{ elasticsearch.pkg }}

{% if elasticsearch.plugins is defined %}
    {% for plugin in elasticsearch.plugins %}
elasticsearch_{{ plugin }}_plugin:
  cmd.run:
    - name: bin/elasticsearch-plugin install {{ plugin }}
    - cwd: /usr/share/elasticsearch
    - unless: /usr/share/elasticsearch/bin/elasticsearch-plugin list | grep {{ plugin }}
    - watch_in:
      - service: elasticsearch_service
    {% endfor %}
{% endif %}
