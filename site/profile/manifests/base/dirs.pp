#profile creating the system directories
class profile::base::dirs {
  lookup('profile::base::dirs').each |$dir| {
    files::system_directory { $dir['title']:
      ensure    => $dir['ensure'],# can be absent
      mode      => $dir['mode'],
      file_mode => $dir['file_mode'],
      owner     => $dir['owner'],
      group     => $dir['group'],
      force     => $dir['force'],
      recurse   => $dir['recurse'],
    }
  }
}
