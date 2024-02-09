#profile creating the ssh system users
class profile::base::ssh_system_users {
  lookup('profile::base::ssh_system_users').each |$user| {
    user_accounts::ssh_system_user { $user['title']:
        ensure           => $user['ensure'],
        comment          => $user['comment'],
        groups           => $user['groups'],
        home             => $user['home'],
        ssh_title        => $user['ssh_title'],
        password_max_age => $user['password_max_age'],
        password_min_age => $user['password_min_age'],
        shell            => $user['shell'],
        uid              => $user['uid'],
        managehome       => $user['managehome'],
        pub_key          => $user['pub_key'],
    }
  }
}
