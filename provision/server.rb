require 'chef/provisioning'

server_config = <<-ENDCONFIG
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end
  config.vm.network "private_network", ip: "172.16.0.100"
ENDCONFIG

machine 'server' do
  add_machine_options vagrant_config: server_config
  recipe 'rancher::server'
  recipe 'rancher::agent'
  chef_environment 'vagrant'
  converge true
end
