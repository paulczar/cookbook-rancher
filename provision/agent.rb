require 'chef/provisioning'

agent_config = <<-ENDCONFIG
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end
  config.vm.network "private_network", ip: "172.16.0.101"
ENDCONFIG

machine 'agent' do
  add_machine_options vagrant_config: agent_config
  recipe 'rancher::agent'
  chef_environment 'vagrant'
  converge true
end
