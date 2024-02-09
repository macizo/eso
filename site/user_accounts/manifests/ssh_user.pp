#defined type for ssh users
define user_accounts::ssh_user (
  $comment,
  $uid,
  $pub_key,
  $groups,
  $ssh_title        = undef,
  $password_max_age = '99999',
  $password_min_age = '0',
  $managehome       = true,
  $ensure           = present,
  $shell            = '/bin/bash',
  $gid              = undef, #by default the gid will be the same as the uid, otherwise it'll be assigned a different gid
  $options          = undef,
){
  if $gid {
    user { $title:
      ensure           =>  $ensure,
      uid              =>  $uid,
      gid              =>  $gid,
      groups           =>  $groups,
      shell            =>  $shell,
      home             =>  "/home/${title}",
      password_max_age =>  $password_max_age,
      password_min_age =>  $password_min_age,
      comment          =>  $comment,
      managehome       =>  $managehome,
      purge_ssh_keys   =>  true,
      membership       =>  inclusive,
    }
  }
  else {
    user { $title:
      ensure           =>  $ensure,
      uid              =>  $uid,#creates group with the same gid as the uid
      groups           =>  $groups,
      shell            =>  $shell,
      home             =>  "/home/${title}",
      password_max_age =>  $password_max_age,
      password_min_age =>  $password_min_age,
      comment          =>  $comment,
      managehome       =>  $managehome,
      purge_ssh_keys   =>  true,
      membership       =>  inclusive,
    }
  }
  if $ssh_title {
    ssh_authorized_key { $ssh_title: # ssh key description
        ensure  => $ensure,
        user    => $title,
        type    => 'ssh-rsa',
        key     => $pub_key,
        options => $options,
    }
  }
}
