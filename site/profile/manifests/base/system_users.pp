#profile creating the system users
class profile::base::system_users {
  lookup('profile::base::system_users').each |$user| {
    user_accounts::system_user { $user['title']:
        ensure           => $user['ensure'],
        comment          => $user['comment'],
        groups           => $user['groups'],
        home             => $user['home'],
        password_max_age => $user['password_max_age'],
        password_min_age => $user['password_min_age'],
        shell            => $user['shell'],
        uid              => $user['uid'],
        gid              => $user['gid'],
        managehome       => $user['managehome'],
    }
  }
}
