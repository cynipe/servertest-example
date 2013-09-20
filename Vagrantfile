Vagrant.configure('2') do |config|
  config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'
  config.vm.box = 'centos-64-x64-vbox4210'

  config.cache.auto_detect = true
  config.vbguest.auto_update = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '512']
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifest_file  = 'site.pp'
    puppet.manifests_path = 'manifests'
    puppet.module_path    = %w(modules)
    puppet.facter = { }
    puppet.options = '--show_diff'
  end

  config.vm.define :web do |host|
    host.vm.hostname = 'web01' # actual name like web01, web02...
    host.vm.network :private_network, :ip => '10.0.0.10'
  end

  config.vm.define :db do |host|
    host.vm.hostname = 'db01' # actual name like db01, db02...
    host.vm.network :private_network, :ip => '10.0.0.20'
  end
end

