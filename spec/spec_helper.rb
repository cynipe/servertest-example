require 'serverspec'
require 'pathname'
require 'net/ssh'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

def run(cmd)
  actual_cmd = [cmd, ENV['TARGET_VM']].join ' '
  puts "Running `#{actual_cmd}`"
  `#{actual_cmd}`
end

RSpec.configure do |c|
  ENV['ASK_SUDO_PASSWORD'] = '0'
  abort 'No target vm specified, please set TARGET_VM env var for that.' unless ENV['TARGET_VM']

  puts run('vagrant destroy --force')
  puts run('vagrant up --no-provision')
  puts run('vagrant provision') unless ENV['SKIP_PROVISION']

  config = run('vagrant ssh-config').split("\n").reduce({}) do |mem, line|
    if line.match(/HostName (.*?)$/)
      mem[:host_name] = $1
    elsif line.match(/User (\w*?)$/)
      mem[:user] = $1
    elsif line.match(/Port (\d*?)$/)
      mem[:port] = $1
    elsif line.match(/IdentityFile (.*?)$/)
      mem[:keys] = [$1]
    end
    mem
  end

  c.host = config[:host_name]
  c.ssh   = Net::SSH.start(c.host, config[:user], config)
  c.os    = backend.check_os

  at_exit { run('vagrant suspend') }
end
