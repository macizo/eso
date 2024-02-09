#profile creating the ssh keys
class profile::base::ssh_keys {
  lookup('profile::base::ssh_keys').each |$key| {
    auth::ssh_key { $key['title']:
      ensure  => $key['ensure'],
      user    => $key['user'],
      type    => $key['type'],
      pub_key => $key['pub_key'],
      options => $key['options'],
    }
  }
}
