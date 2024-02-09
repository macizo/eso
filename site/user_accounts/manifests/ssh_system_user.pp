#defined type for ssh system users
define user_accounts::ssh_system_user (
  $pub_key,
  $comment,
  $uid,
  $groups,
  $ssh_title,
  $password_max_age  = '99999',
  $password_min_age  = '0',
  $managehome        = true,
  $shell             = '/bin/bash',
  $ensure            = present,
  $home              = undef,
  $gid               = undef,#by default the gid will be the same as the uid, otherwise it'll be assigned a different gid
  $options           = undef,
){

  if $home == undef{
    $user_home = "/home/${title}"
  }
  else {
    $user_home = $home
  }

  if $gid {
    user { $title:
      ensure           =>  $ensure,
      uid              =>  $uid,
      gid              =>  $gid,
      groups           =>  $groups,
      shell            =>  $shell,
      home             =>  $user_home,
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
      home             =>  $user_home,
      password_max_age =>  $password_max_age,
      password_min_age =>  $password_min_age,
      comment          =>  $comment,
      managehome       =>  $managehome,
      purge_ssh_keys   =>  true,
      membership       =>  inclusive,
    }
  }

  # Adding the user key to the user authorized_keys.
  if $ssh_title {
    ssh_authorized_key { $ssh_title:
        ensure  => $ensure,
        user    => $title,
        type    => 'ssh-rsa',
        key     => $pub_key,
        options => $options,
    }
  }
}
