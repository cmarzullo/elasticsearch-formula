# -*- coding: utf-8 -*-
# vim: ft=sls
# Init Elasticsearch
{%- from "elasticsearch/map.jinja" import elasticsearch with context %}

{% if elasticsearch.enabled %}
include:
  - elasticsearch.install
  - elasticsearch.config
  - elasticsearch.service
{% else %}
'elasticsearch-formula disabled':
  test.succeed_without_changes
{% endif %}