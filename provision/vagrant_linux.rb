require 'chef/provisioning/vagrant_driver'

vagrant_box 'opscode-ubuntu-14.04' do
  url 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'
end

os = ENV['REPO_OS'] || 'opscode-ubuntu-14.04'

with_driver "vagrant:#{File.dirname(__FILE__)}/vms"
with_machine_options vagrant_options: {
  'vm.box' => os
}
