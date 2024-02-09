#profile creating the scripts
class profile::cis::scripts{
  lookup('profile::cis::scripts').each |$file| {
    files::system_file { $file['title']:
      ensure  => $file['ensure'],
      mode    => $file['mode'],
      owner   => $file['owner'],
      group   => $file['group'],
      content => $file['content'],
    }
  }
}


