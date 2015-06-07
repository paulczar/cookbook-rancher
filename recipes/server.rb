#
# Cookbook Name:: rancher
# Recipe:: server
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'chef-sugar::default'
include_recipe 'docker::default'

docker_image node['rancher']['server']['image'] do
  tag node['rancher']['server']['version']
  action :pull
end

docker_container 'rancher-server' do
  image node['rancher']['server']['image']
  tag node['rancher']['server']['version']
  detach true
  port "#{node['rancher']['server']['port']}:8080"
end
