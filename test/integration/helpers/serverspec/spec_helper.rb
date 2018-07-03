require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('elasticsearch') do
  it { should be_installed }
end

describe package('openjdk-8-jre-headless'), :if => os[:family] == 'debian'do
  it { should be_installed }
end

describe package('java-1.8.0-openjdk-headless'), :if => os[:family] == 'redhat'do
  it { should be_installed }
end
