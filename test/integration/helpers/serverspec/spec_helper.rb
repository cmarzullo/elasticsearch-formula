require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('elasticsearch') do
  it { should be_installed }
end

describe package('openjdk-8-jre-headless') do
  it { should be_installed }
end
