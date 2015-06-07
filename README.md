# rancher

Installs [Rancher](http://rancher.com/rancher-io/)

# attributes

documentation for attributes is inline at: [attributes/default.rb](attributes/default.rb)

# recipes

## server.rb

Installs Rancher labs server.

Run this on your `primary` node.

## agent.rb

Installs Rancher labs agent.

Run this on all nodes.

# Usage

## Kitchen

This is mostly used for cookbook development and testing:

```
$ kitchen converge ubuntu
$ curl localhost:8080
```

## Chef-Provisioning

Note: If you have chefdk 0.6.0 you may need to install a newer `chef-provisioning` gem to overcome the bug described [here](https://github.com/chef/chef-provisioning/pull/337).  To do this run `chef gem install chef-provisioning`.

### Vagrant

This will create a two node rancher cluster utilizing the vagrant module for chef provisioning:

```
$ rake vendor_cookbooks
$ rake server agent
$ curl localhost:8080
```

to access the VMs you need to be in the `provision/vms` directory:

```
$ cd provision/vms
$ vagrant ssh agent
vagrant@agent:~$ sudo docker ps
CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS               NAMES
40ce0296df02        rancher/agent:v0.7.9   "/run.sh run"       4 minutes ago       Up 4 minutes                            rancher-agent

```
