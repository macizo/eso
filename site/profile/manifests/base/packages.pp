#profile installing packages
class profile::base::packages {
  package { lookup('profile::base::pkgs'):
    ensure => present,
  }
}
