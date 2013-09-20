require 'spec_helper'

describe package('postgresql-server') do
  it { should be_installed }
end

describe service('postgresql') do
  it { should be_running }
  it { should be_enabled }
end

describe port(5432) do
  it { should be_listening }
end

describe file('/var/lib/pgsql/data/postgresql.conf') do
  it { should be_file }
  it { should contain %q{listen_addresses = '*'} }
end

describe file('/var/lib/pgsql/data/pg_hba.conf') do
  it { should be_file }
  it { should contain %q{host	all	postgres	0.0.0.0/32	reject} }
  it { should contain %q{host	all	all	0.0.0.0/0	md5} }
end

