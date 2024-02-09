#profile starting services 
class profile::cis::services {
  lookup(profile::cis::services).each |$service| {
    cis::service { $service['title']:
      ensure => $service['ensure'],
    }
  }
}
