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
  server = search('node', "name:#{node['rancher']['server']['node_name']}").first
  server_host = best_ip_for(server)
  if ! server_host
    if includes_recipe?('rancher::server')
      server_host = node['ipaddress']
    else
      log "cannot find rancher server.  going to use local IP and hope for the best"
      server_host = node['ipaddress']
    end
  end
end

log "agent_server_log" do
  message "Agent will connect to server: http://#{server_host}:#{node['rancher']['server']['port']}"
  level :info
end

docker_image node['rancher']['agent']['image'] do
  tag node['rancher']['agent']['version']
  action :pull
end

docker_container 'rancher-agent' do
  image node['rancher']['agent']['image']
  tag node['rancher']['agent']['version']
  detach true
  command "http://#{server_host}:#{node['rancher']['server']['port']}"
  volume '/var/run/docker.sock:/var/run/docker.sock'
end
