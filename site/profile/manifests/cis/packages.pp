#profile installing packages
class profile::cis::packages {
  package { lookup('profile::cis::pkgs'):
    ensure => absent,
  }
}
