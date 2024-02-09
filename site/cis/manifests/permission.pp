#set permissions
define cis::permission (
  $mode    = undef,
  $owner   = 'root',
  $group   = 'root',
  $ensure  = present,
  $content = undef,
){
  file { $title:
    ensure  => $ensure,
    mode    => $mode,
    group   => $group,
    path    => $title,
    content => $content,
  }
}
