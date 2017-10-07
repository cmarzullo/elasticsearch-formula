require 'spec_helper'

describe file('/etc/elasticsearch/elasticsearch.yml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq '6957612f26051d6d3da76b1afd7829548cfb9a5fe203526057f99ada73887724' }
end

describe file('/etc/elasticsearch/jvm.options') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq '1b092a2eea7cc5c8258301b3c991e6fc578836a9304d92c15dc36a4660d2d071' }
end

describe file('/etc/elasticsearch/log4j2.properties') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'elasticsearch' }
  its(:sha256sum) { should eq 'fe889153b804253ac0aea13e7f985bb0b7b9303dd847e44b5afb278f68517227' }
end

describe file('/etc/default/elasticsearch') do
  it { should exist }
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:sha256sum) { should eq 'b5ef00f53a2c91ce8ca8adfec8032d4fd4f7b99d70751fe7e15755e6d72a663d' }
end
