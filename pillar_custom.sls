# -*- coding: utf-8 -*-
# vim: ft=yaml
---
elasticsearch:
  enabled: True
  service:
    name: elasticsearch
    state: running
    enable: True
  conf:
    cluster.name: testing_cluster
    path.data: /var/lib/elasticsearch
    path.logs: /var/log/elasticsearch
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
    xpack.security.audit.enabled: True
    xpack.ssl.key: /etc/elasticsearch/pki/test_ca/certs/elasticsearch.key
    xpack.ssl.certificate: /etc/elasticsearch/pki/test_ca/certs/elasticsearch.crt
    xpack.ssl.certificate_authorities:
      - /etc/elasticsearch/pki/test_ca/test_ca_ca_cert.crt
    xpack.security.transport.ssl.enabled: true
    xpack.security.http.ssl.enabled: true
    xpack.security.authc.realms:
      file1:
        type: file
        order: 0
    xpack.ml.enabled: true
    node.ml: true
  jvm_options:
    - -Xms1g
    - -Xmx1g
    - -XX:+UseConcMarkSweepGC
    - -XX:CMSInitiatingOccupancyFraction=75
    - -XX:+UseCMSInitiatingOccupancyOnly
    - -XX:+AlwaysPreTouch
    - -server
    - -Xss1m
    - -Djava.awt.headless=true
    - -Dfile.encoding=UTF-8
    - -Djna.nosys=true
    - -Djdk.io.permissionsUseCanonicalPath=true
    - -Dio.netty.noUnsafe=true
    - -Dio.netty.noKeySetOptimization=true
    - -Dio.netty.recycler.maxCapacityPerThread=0
    - -Dlog4j.shutdownHookEnabled=false
    - -Dlog4j2.disable.jmx=true
    - -Dlog4j.skipJansi=true
    - -XX:+HeapDumpOnOutOfMemoryError
  log4j2_properties:
    appender.audit_rolling.fileName: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_access.log"
    appender.audit_rolling.filePattern: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_access-%d{yyyy-MM-dd-HH-mm}.log.gz"
    appender.audit_rolling.layout.pattern: "[%d{ISO8601}] %m%n"
    appender.audit_rolling.layout.type: PatternLayout
    appender.audit_rolling.name: audit_rolling
    appender.audit_rolling.policies.time.interval: 1
    appender.audit_rolling.policies.time.modulate: true
    appender.audit_rolling.policies.time.type: TimeBasedTriggeringPolicy
    appender.audit_rolling.policies.type: Policies
    appender.audit_rolling.strategy.action.PathConditions.glob: "${sys:es.logs.cluster_name}_access-*"
    appender.audit_rolling.strategy.action.PathConditions.type: IfFileName
    appender.audit_rolling.strategy.action.basepath: "${sys:es.logs.base_path}"
    appender.audit_rolling.strategy.action.condition.age: 5m
    appender.audit_rolling.strategy.action.condition.type: IfLastModified
    appender.audit_rolling.strategy.action.type: Delete
    appender.audit_rolling.strategy.type: DefaultRolloverStrategy
    appender.audit_rolling.type: RollingFile
    appender.console.layout.pattern: "[%d{ISO8601}][%-5p][%-25c{1.}] %marker%m%n"
    appender.console.layout.type: PatternLayout
    appender.console.name: console
    appender.console.type: Console
    appender.deprecation_rolling.fileName: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_deprecation.log"
    appender.deprecation_rolling.filePattern: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_deprecation-%i.log.gz"
    appender.deprecation_rolling.layout.pattern: "[%d{ISO8601}][%-5p][%-25c{1.}] %marker%.-10000m%n"
    appender.deprecation_rolling.layout.type: PatternLayout
    appender.deprecation_rolling.name: deprecation_rolling
    appender.deprecation_rolling.policies.size.size: 1GB
    appender.deprecation_rolling.policies.size.type: SizeBasedTriggeringPolicy
    appender.deprecation_rolling.policies.type: Policies
    appender.deprecation_rolling.strategy.fileIndex: min
    appender.deprecation_rolling.strategy.max: 4
    appender.deprecation_rolling.strategy.type: DefaultRolloverStrategy
    appender.deprecation_rolling.type: RollingFile
    appender.index_indexing_slowlog_rolling.fileName: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_index_indexing_slowlog.log"
    appender.index_indexing_slowlog_rolling.filePattern: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_index_indexing_slowlog-%d{yyyy-MM-dd}.log.gz"
    appender.index_indexing_slowlog_rolling.layout.pattern: "[%d{ISO8601}][%-5p][%-25c] %marker%.-10000m%n"
    appender.index_indexing_slowlog_rolling.layout.type: PatternLayout
    appender.index_indexing_slowlog_rolling.name: index_indexing_slowlog_rolling
    appender.index_indexing_slowlog_rolling.policies.time.interval: 1
    appender.index_indexing_slowlog_rolling.policies.time.modulate: "true"
    appender.index_indexing_slowlog_rolling.policies.time.type: TimeBasedTriggeringPolicy
    appender.index_indexing_slowlog_rolling.policies.type: Policies
    appender.index_indexing_slowlog_rolling.type: RollingFile
    appender.index_search_slowlog_rolling.fileName: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_index_search_slowlog.log"
    appender.index_search_slowlog_rolling.filePattern: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_index_search_slowlog-%d{yyyy-MM-dd}.log.gz"
    appender.index_search_slowlog_rolling.layout.pattern: "[%d{ISO8601}][%-5p][%-25c] %marker%.-10000m%n"
    appender.index_search_slowlog_rolling.layout.type: PatternLayout
    appender.index_search_slowlog_rolling.name: index_search_slowlog_rolling
    appender.index_search_slowlog_rolling.policies.time.interval: 1
    appender.index_search_slowlog_rolling.policies.time.modulate: "true"
    appender.index_search_slowlog_rolling.policies.time.type: TimeBasedTriggeringPolicy
    appender.index_search_slowlog_rolling.policies.type: Policies
    appender.index_search_slowlog_rolling.type: RollingFile
    appender.rolling.fileName: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}.log"
    appender.rolling.filePattern: "${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}-%d{yyyy-MM-dd-HH-mm}.log.gz"
    appender.rolling.layout.pattern: "[%d{ISO8601}][%-5p][%-25c{1.}] %marker%.-10000m%n"
    appender.rolling.layout.type: PatternLayout
    appender.rolling.name: rolling
    appender.rolling.policies.time.interval: 1
    appender.rolling.policies.time.modulate: "true"
    appender.rolling.policies.time.type: TimeBasedTriggeringPolicy
    appender.rolling.policies.type: Policies
    appender.rolling.strategy.action.PathConditions.glob: ${sys:es.logs.cluster_name}-*
    appender.rolling.strategy.action.PathConditions.type: IfFileName 
    appender.rolling.strategy.action.basepath: ${sys:es.logs.base_path} 
    appender.rolling.strategy.action.condition.age: 7D 
    appender.rolling.strategy.action.condition.type: IfLastModified 
    appender.rolling.strategy.action.type: Delete 
    appender.rolling.strategy.fileIndex: min
    appender.rolling.strategy.max: 7
    appender.rolling.strategy.type: DefaultRolloverStrategy
    appender.rolling.type: RollingFile
    logger.action.level: debug
    logger.action.name: org.elasticsearch.action
    logger.deprecation.additivity: "false"
    logger.deprecation.appenderRef.deprecation_rolling.ref: deprecation_rolling
    logger.deprecation.level: warn
    logger.deprecation.name: org.elasticsearch.deprecation
    logger.index_indexing_slowlog.additivity: "false"
    logger.index_indexing_slowlog.appenderRef.index_indexing_slowlog_rolling.ref: index_indexing_slowlog_rolling
    logger.index_indexing_slowlog.level: trace
    logger.index_indexing_slowlog.name: index.indexing.slowlog.index
    logger.index_search_slowlog_rolling.additivity: "false"
    logger.index_search_slowlog_rolling.appenderRef.index_search_slowlog_rolling.ref: index_search_slowlog_rolling
    logger.index_search_slowlog_rolling.level: trace
    logger.index_search_slowlog_rolling.name: index.search.slowlog
    logger.xpack_security_audit_logfile.additivity: "false"
    logger.xpack_security_audit_logfile.appenderRef.audit_rolling.ref: audit_rolling
    logger.xpack_security_audit_logfile.level: info
    logger.xpack_security_audit_logfile.name: org.elasticsearch.xpack.security.audit.logfile.LoggingAuditTrail
    rootLogger.appenderRef.console.ref: console
    rootLogger.appenderRef.rolling.ref: rolling
    rootLogger.level: info
    status: error
  roles:
    monitoring_user:
      - m_user
    kibana_user:
      - k_user
    reporting_user:
      - r_user
    superuser:
      - e_admin
    machine_learning_admin:
      - k_user
  roles_custom:
    click_admins:
      run_as: [ 'clicks_watcher_1' ]
      cluster: [ 'monitor' ]
      indices:
        - names: [ 'events-*' ]
          privileges: [ 'read' ]
          field_security:
            grant: ['category', '@timestamp', 'message' ]
          query: '{"match": {"category": "click"}}'
  # password is sgisgi
  users:
    - name: r_user
      password: $2a$10$P7jM0GFBu.6tBR8ltIjcReFpBmtj.1wKSryeUePInOQOgxE.qSBTC
    - name: e_admin
      password: $2a$10$0DIzDqHG80nUniykeIvNSOBoOlKAcN/wrbob1l7ZeVlP5B9wqKMci
    - name: m_user
      password: $2a$10$KlJDFOa0FQ6QcJlp9fUx.erKQrkyaIt5xKb6j2OZlFMuZJPOWlTGW
    - name: k_user
      password: $2a$10$r6nRsvlQ0s5fNWmCaW0cLuX6qhZTJ3OZ61otePTnUPgBSQJiLU7Pe
