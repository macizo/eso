#profile installing packages
class profile::base::latest {
  package { lookup('profile::base::latest'):
    ensure => latest,
  }
}
