require 'spec_helper'

describe file('/etc/elasticsearch/elasticsearch.yml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq '07ec2f659f388eddf7ee1abfccb7e8234018f4c0cddda2f00be4c3f531702d5d' }
end

describe file('/etc/elasticsearch/jvm.options') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq '1c15165de94fb224520b93a0c1258910290134923a4fcd0392011b2480d1c3da' }
end

describe file('/etc/elasticsearch/log4j2.properties') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq 'dfb9dfad8ab87f0b5789291f9797c6ed55c0868f315496e4c3a035cf879f05c9' }
end

describe file('/etc/default/elasticsearch'), :if => os[:family] == 'debian' do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq '46c410bafb031ff5cc4f78e204e30e0bac5e23c7aae1c7b937458feba6209265' }
end

describe file('/etc/sysconfig/elasticsearch'), :if => os[:family] == 'redhat' do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq '46c410bafb031ff5cc4f78e204e30e0bac5e23c7aae1c7b937458feba6209265' }
end
