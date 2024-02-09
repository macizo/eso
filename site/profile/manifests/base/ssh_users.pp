#profile creating the ssh users
class profile::base::ssh_users{
  lookup('profile::base::ssh_users').each |$user| {
    user_accounts::ssh_user { $user['title']:
        ensure           => $user['ensure'],
        comment          => $user['comment'],
        pub_key          => $user['pub_key'],
        ssh_title        => $user['ssh_title'],
        groups           => $user['groups'],
        password_max_age => $user['password_max_age'],
        password_min_age => $user['password_min_age'],
        shell            => $user['shell'],
        uid              => $user['uid'],
        gid              => $user['gid'],
        managehome       => $user['managehome'],
    }
  }
}
