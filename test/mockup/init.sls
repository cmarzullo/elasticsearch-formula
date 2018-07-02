{% from "elasticsearch/map.jinja" import elasticsearch with context %}
elasticsearch_mockup_deps:
  pkg.installed:
    - pkgs:
      - haveged

{% if grains.os_family == "Debian" %}
elasticsearch_repo_managed:
  pkgrepo.managed:
    - humanname: Elasticsearch Repo
    - name: deb https://artifacts.elastic.co/packages/6.x/apt stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elastic-6.x.list
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch
    - refresh_db: True
    
jessie_backports_repo_managed:
  pkgrepo.managed:
    - humanname: Jessie Backports
    - name: deb http://ftp.debian.org/debian jessie-backports main
    - file: /etc/apt/sources.list.d/jessie-backports.list
{% endif %}

elasticsearch_pki_dir:
  file.directory:
    - name: /etc/pki
    - makedirs: True

elasticsearch_mockup_tls_config:
  file.managed:
    - name: /etc/salt/minion.d/ca.conf
    - contents:
      - "ca.cert_base_path: /etc/pki"

elasticsearch_mockup_ssl_create_ca:
  module.run:
    - name: tls.create_ca
    - ca_name: test_ca
    - days: 5
    - CN: MyTestCA
    - C: US
    - ST: MyState
    - L: MyCity
    - O: MyOrgUnit
    - emailAddress: test@example.com
    - unless: test -f /etc/pki/test_ca/test_ca_ca_cert.crt

elasticsearch_mockup_ssl_create_csr:
  module.run:
    - name: tls.create_csr
    - ca_name: test_ca
    - CN: elasticsearch
    - unless: test -f /etc/pki/test_ca/certs/elasticsearch.key

elasticsearch_mockup_ssl_sign_csr:
  module.run:
    - name: tls.create_ca_signed_cert
    - ca_name: test_ca
    - CN: elasticsearch
    - unless: test -f /etc/pki/test_ca/certs/elasticsearch.crt

elasticsearch_copy_cert:
  file.copy:
    - name: /etc/elasticsearch/pki/test_ca/certs/elasticsearch.crt
    - source: /etc/pki/test_ca/certs/elasticsearch.crt
    - makedirs: True

elasticsearch_copy_key:
  file.copy:
    - name: /etc/elasticsearch/pki/test_ca/certs/elasticsearch.key
    - source: /etc/pki/test_ca/certs/elasticsearch.key
    - makedirs: True

elasticsearch_copy_cacert:
  file.copy:
    - name: /etc/elasticsearch/pki/test_ca/test_ca_ca_cert.crt
    - source: /etc/pki/test_ca/test_ca_ca_cert.crt
    - makedirs: True
