#profile calling the sysctl module 
class profile::cis::sysctl {
  class {'sysctl_conf':
    values   => lookup(sysctl_conf::values),
  }
}
