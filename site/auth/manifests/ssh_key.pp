#defined type for an ssh key
define auth::ssh_key (
    $user,
    $pub_key,
    $ensure    = present,
    $type      = 'ssh-rsa',
    $options   = undef,
){
  ssh_authorized_key { $title:
    ensure  => $ensure,
    user    => $user,
    type    => $type,
    key     => $pub_key,
    options => $options,
  }
}
