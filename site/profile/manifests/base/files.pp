#profile creating the system files
class profile::base::files{
  lookup('profile::base::files').each |$file| {
    files::system_file { $file['title']:
      ensure  => $file['ensure'],
      mode    => $file['mode'],
      owner   => $file['owner'],
      group   => $file['group'],
      content => $file['content'],
    }
  }
}
