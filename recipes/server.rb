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

docker_container 'rancher-server-data' do
  image node['rancher']['server']['image']
  tag node['rancher']['server']['version']
  volume ['/var/lib/mysql','/var/lib/cattle']
  entrypoint '/bin/true'
  init_type false
  action :create
  container_name 'rancher-server-data'
  only_if { node['rancher']['server']['volume_container'] }
end

docker_container 'rancher-server' do
  image node['rancher']['server']['image']
  tag node['rancher']['server']['version']
  detach true
  container_name 'rancher-server'
  volumes_from 'rancher-server-data' if node['rancher']['server']['volume_container']
  port "#{node['rancher']['server']['port']}:8080"
  action :run
end
