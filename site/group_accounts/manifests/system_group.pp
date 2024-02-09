#defined type for system groups
define group_accounts::system_group (
  $gid,
  $ensure  = present,
){
# When using top-scope variables, including facts, Puppet modules 
# should explicitly specify the empty namespace to prevent accidental scoping issues. (style guide)
  group { $title:
    ensure => $ensure,
    gid    => $gid,
  }
}
