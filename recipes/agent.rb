#
# Cookbook Name:: rancher
# Recipe:: agent
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'chef-sugar::default'
include_recipe 'docker::default'

if node['rancher']['server']['host']
    server_host = node['rancher']['server']['host']
else
  if Chef::Config[:solo]
    Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
    if includes_recipe?('rancher::server')
      server_host = node['ipaddress']
    else
      Chef::Log.warn("cannot find rancher server.  going to use local IP and hope for the best")
      server_host = node['ipaddress']
    end
  else
    server = search('node', "name:#{node['rancher']['server']['node_name']}").first
    server_host = best_ip_for(server)
  end
end

Chef::Log.info("Agent will connect to server: http://#{server_host}:#{node['rancher']['server']['port']}")

docker_image node['rancher']['agent']['image'] do
  tag node['rancher']['agent']['version']
  action :pull
end

docker_container 'rancher-agent' do
  image node['rancher']['agent']['image']
  tag node['rancher']['agent']['version']
  command "http://#{server_host}:#{node['rancher']['server']['port']}"
  volume '/var/run/docker.sock:/var/run/docker.sock'
  container_name 'rancher-agent-init'
  init_type false
  detach false
  not_if 'docker inspect rancher-agent'
end
