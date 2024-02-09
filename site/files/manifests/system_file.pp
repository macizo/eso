#defined type for system files
define files::system_file (
  $mode,
  $owner     = 'root',
  $group     = 'root',
  $ensure    = 'present',
  $content   =  undef,
){
  if $content == undef {
    file { $title:
      ensure => $ensure,
      mode   => $mode,
      owner  => $owner,
      group  => $group,
      # replace => no,
    }
  }
  # copy from template
  else {
    file { $title:
      ensure  => $ensure,
      mode    => $mode,
      owner   => $owner,
      group   => $group,
      content => template($content),
    }
  }
}
