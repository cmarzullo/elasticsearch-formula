# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_service:
  service.{{ elasticsearch.service.state }}:
    - name: {{ elasticsearch.service.name }}
    - enable: {{ elasticsearch.service.enable }}
