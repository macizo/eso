#defined type for system directory
#title: name
#owner: me
#group: mygroup
#force: yes to delete
#file_mode: eg. 0644 to set this permission to all files under directory
define files::system_directory (
  $mode,
  $owner,
  $group,
  $force     = false,
  $file_mode = undef,
  $recurse   = false,
  $ensure    = directory
){
  if $recurse {
      file { $title:
        ensure   =>  $ensure,
      }
      if $file_mode { #set permissions for files in directory
        recursive_file_permissions { $title:
          file_mode => $file_mode,
          dir_mode  => $mode,
          owner     => $owner,
          group     => $group,
        }
      }
      else {
        recursive_file_permissions { $title:
          dir_mode => $mode,
          owner    => $owner,
          group    => $group,
        }
      }
  }
  else {
    file { $title:
      ensure =>  $ensure,
      force  => $force,
      mode   => $mode,
      owner  => $owner,
      group  => $group,
    }
  }
}
