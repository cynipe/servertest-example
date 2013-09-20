require 'spec_helper'

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_running }
  it { should be_enabled }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/httpd/conf.d/25-test.example.com.conf') do
  it { should be_file }
  it { should contain 'ServerName test.example.com' }
  it { should contain 'DocumentRoot /var/www/test' }
end

