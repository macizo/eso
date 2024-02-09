#profile creating the mount resources 
class profile::cis::mounts {
  lookup(profile::cis::mounts).each |$mount| {
      cis::mount { $mount['title']:
        ensure  => $mount['ensure'],
        options => $mount['options'],
        fstype  => $mount['fstype'],
        device  => $mount['device'],
    }
  }
}
