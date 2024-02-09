#profile creating the system groups
class profile::base::groups{
  lookup('profile::base::groups').each |$group|{
    group_accounts::system_group { $group['title']:
          ensure => $group['ensure'],
          gid    => $group['gid'],
    }
  }
}
