#disable modules
class profile::cis::kmod {
  class {'kmod':
    list_of_installs   => lookup(kmod::list_of_installs),
  }
}
