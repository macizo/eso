#profile changing permissions 
class profile::cis::permissions {
  lookup(profile::cis::files).each |$file| {
    cis::permission { $file['title']:
      mode    => $file['mode'],
      owner   => $file['owner'],
      group   => $file['group'],
      content => $file['content'],
    }
  }
}
