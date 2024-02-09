#class for services
define cis::service (
  $ensure = stopped,
){
    service { $title:
      ensure => $ensure,
  }
}
