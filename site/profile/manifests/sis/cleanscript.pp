# housekeeping scripts for SIS
class profile::sis::cleanscript {
  #creates scripts
  lookup('profile::sis::cleanscripts').each |$script| {
    files::system_file { $script['title']:
      ensure  => $script['ensure'],
      mode    => $script['mode'],
      owner   => $script['owner'],
      group   => $script['group'],
      content => $script['content'],
    }
  }
}
