#defined type for system users
define user_accounts::system_user (
  $home,
  $comment,
  $uid,
  $ensure           = present,
  $shell            = '/bin/bash',
  $groups           = 'users',
  $password_max_age = '99999',
  $password_min_age = '0',
  $managehome       = true,
  $gid              = undef,#by default the gid will be the same as the uid, otherwise it'll be assigned a different gid
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
      home             =>  $home,
      password_max_age =>  $password_max_age,
      password_min_age =>  $password_min_age,
      comment          =>  $comment,
      managehome       =>  $managehome,
    }
  }
  else {
    user { $title:
      ensure           =>  $ensure,
      uid              =>  $uid,#creates group with the same gid as the uid
      groups           =>  $groups,
      shell            =>  $shell,
      home             =>  $home,
      password_max_age =>  $password_max_age,
      password_min_age =>  $password_min_age,
      comment          =>  $comment,
      managehome       =>  $managehome,
    }
  }
}
