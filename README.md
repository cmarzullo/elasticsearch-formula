elasticsearch-formula
=====================

Salt formula to install and configure Elasticsearch.

## Usage
### Defaults
By default, the formula itself disabled as well as the service. The necessary repositories (elasticsearch, jessie-backports) are enabled for mockup and testing.
```
elasticsearch:
  enabled: False
  required_pkgs:
    - elasticsearch
    - openjdk-8-jre-headless
  service:
    name: elasticsearch
    state: dead
    enable: False
  default:
    ES_STARTUP_SLEEP_TIME: 5
  conf: []
```

### Normal usage
You can install plugins like Shield, Watcher, and Marvel as well as control other configuration variables. The config files are set to render pure yaml, or loop through the defined options and give the proper output (/etc/default/elasticsearch). See pillar_custom.sls for a more realistic example.
```
elasticsearch:
  enabled: True
  service:
    name: elasticsearch
    state: running
    enable: True
  default:
    ES_HEAP_SIZE: 1g
  plugins:
    names:
      - shield
      - watcher
      - marvel-agent
  conf:
    cluster.name: testing_cluster
    node.name: es1
    node.master: true
    node.data: true
    node.max_local_storage_nodes: 1
    network.host: 0.0.0.0
    http.port: 9200
    discovery.zen.ping.unicast.hosts:
		  - localhost
    discovery.zen.minimum_master_nodes: 3
    gateway.recover_after_nodes: 6
    gateway.expected_nodes: 10
    gateway.recover_after_time: 5m
    action.destructive_requires_name: true
    shield.audit.enabled: True
    shield.ssl.keystore.path: /etc/elasticsearch/elasticsearch.jks
    shield.ssl.keystore.password: MyPass11
    shield.ssl.keystore.key_password: MyPass11
    shield.transport.ssl: true
    shield.http.ssl: true
  roles:
    kibana4:
      - k_user
    admin:
      - e_admin
  roles_custom:
    kibana4:
      indices:
        '*':
          privileges: indices:admin/mappings/fields/get
        '.kibana':
          privileges: indices:admin/exists, indices:admin/mapping/put
  users:
    - name: 'k_user'
      password: '$2a$10$KYkq0NQ92rNkgKuv3NQnOekZV8R/5ycgogchdZoKzOIbsPTukh/Su'
```
