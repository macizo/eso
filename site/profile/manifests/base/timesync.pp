# Class: timesync
#
class profile::base::timesync {
  # resources
    exec { 'vmware-toolbox-cmd timesync enable':
    provider => shell,
    path     => ['/usr/bin', '/bin',],
    onlyif   => 'test `vmware-toolbox-cmd timesync status` = "Disabled"',
  }
}
