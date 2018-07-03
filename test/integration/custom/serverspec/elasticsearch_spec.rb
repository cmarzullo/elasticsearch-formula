require 'spec_helper'

describe service('elasticsearch') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:content) { should match /^action.destructive_requires_name: true/ }
  its(:content) { should match /^cluster.name: testing_cluster/ }
  its(:content) { should match /^discovery.zen.minimum_master_nodes: 3/ }
  its(:content) { should match /^discovery.zen.ping.unicast.hosts:\n- localhost/ }
  its(:content) { should match /^gateway.expected_nodes: 10/ }
  its(:content) { should match /^gateway.recover_after_nodes: 6/ }
  its(:content) { should match /^gateway.recover_after_time: 5m/ }
  its(:content) { should match /^http.port: 9200/ }
  its(:content) { should match /^network.host: 0.0.0.0/ }
  its(:content) { should match /^node.data: true/ }
  its(:content) { should match /^node.master: true/ }
  its(:content) { should match /^node.max_local_storage_nodes: 1/ }
  its(:content) { should match /^node.name: es1/ }
  its(:content) { should match /^xpack.security.audit.enabled: true/ }
  its(:content) { should match /^xpack.security.http.ssl.enabled: true/ }
  its(:content) { should match /^xpack.security.transport.ssl.enabled: true/ }
  its(:content) { should match /^xpack.ssl.certificate: \/etc\/elasticsearch\/pki\/test_ca\/certs\/elasticsearch.crt/ }
  its(:content) { should match /^xpack.ssl.certificate_authorities:\n- \/etc\/elasticsearch\/pki\/test_ca\/test_ca_ca_cert.crt/ }
  its(:content) { should match /^xpack.ssl.key: \/etc\/elasticsearch\/pki\/test_ca\/certs\/elasticsearch.key/ }
end

describe file('/etc/elasticsearch/jvm.options') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:content) { should match /^-Xms1g/ }
  its(:content) { should match /^-Xmx1g/ }
end

describe file('/etc/elasticsearch/log4j2.properties') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:content) { should match /^status = error/ }
  its(:content) { should match /^appender\.rolling\.filePattern = \$\{sys:es\.logs\.base_path\}\$\{sys:file\.separator\}\$\{sys:es\.logs\.cluster_name\}-\%d\{yyyy-MM-dd-HH-mm\}\.log\.gz/ }
  its(:content) { should match /^appender\.rolling\.strategy\.type = DefaultRolloverStrategy/ }
  its(:content) { should match /^appender\.rolling\.strategy\.max = 7/ }
  its(:content) { should match /^appender\.audit_rolling\.strategy\.type = DefaultRolloverStrategy/ }
  its(:content) { should match /^appender\.audit_rolling\.strategy\.action\.condition.age = 5m/ }
end

describe file('/etc/default/elasticsearch'), :if => os[:family] == 'debian' do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:content) { should match /ES_STARTUP_SLEEP_TIME=5/ }
end

describe file('/etc/sysconfig/elasticsearch'), :if => os[:family] == 'redhat' do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:content) { should match /ES_STARTUP_SLEEP_TIME=5/ }
end

describe file('/etc/elasticsearch/users') do
  it { should exist }
  it { should be_file }
  its(:content) { should match /^r_user\:\$2a\$10\$P7jM0GFBu\.6tBR8ltIjcReFpBmtj\.1wKSryeUePInOQOgxE\.qSBTC/ }
  its(:content) { should match /^k_user\:\$2a\$10\$r6nRsvlQ0s5fNWmCaW0cLuX6qhZTJ3OZ61otePTnUPgBSQJiLU7Pe/ }
  its(:content) { should match /^e_admin\:\$2a\$10\$0DIzDqHG80nUniykeIvNSOBoOlKAcN\/wrbob1l7ZeVlP5B9wqKMci/ }
  its(:content) { should match /^m_user\:\$2a\$10\$KlJDFOa0FQ6QcJlp9fUx\.erKQrkyaIt5xKb6j2OZlFMuZJPOWlTGW/ }
end

describe file('/etc/elasticsearch/users_roles') do
  it { should exist }
  it { should be_file }
  its(:content) { should match /monitoring_user:m_user/ }
  its(:content) { should match /kibana_user:k_user/ }
  its(:content) { should match /reporting_user:r_user/ }
  its(:content) { should match /superuser:e_admin/ }
end

describe file('/etc/elasticsearch/roles.yml') do
  it { should exist }
  it { should be_file }
  its(:content) { should match /^click_admins:/ }
  its(:content) { should match /^  run_as\:\n  - clicks_watcher_1/ }
  its(:content) { should match /^  cluster\:\n  - monitor/ }
  its(:content) { should match /^  indices\:/ }
  its(:content) { should match /^    field_security\:/ }
  its(:content) { should match /^      grant\:\n      - category\n      - '\@timestamp'\n      - message/ }
  its(:content) { should match /^  - names\:\n    - events-\*/ }
  its(:content) { should match /^    privileges\:\n    - read/ }
  its(:content) { should match /^    query\: '\{"match"\: \{"category"\: "click"\}\}'/ }
end

describe file('/etc/elasticsearch/system_key') do
  it { should exist }
  it { should be_file }
  it { should be_mode 640 }
end

describe process('java') do
  its(:user) { should eq "elasticsearch" }
  its(:args) { should match /-Xms1g/ }
  its(:args) { should match /-Xmx1g/ }
  its(:args) { should match /-Des.path.home=\/usr\/share\/elasticsearch/ }
end
