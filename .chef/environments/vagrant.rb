name 'vagrant'
description('vagrant environment for rancher cookbook')

override_attributes(
  'rancher' => {
    'server' => {
      'host' => '172.16.0.100'
    }
  }
}
