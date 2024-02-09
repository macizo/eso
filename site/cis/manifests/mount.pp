#defined type for mounts
define cis::mount (
  $options,
  $fstype,
  $ensure = mounted,
  $device = undef,
){
  mount { $title:
    name     => $title,
    options  => $options,
    fstype   => $fstype,
    device   => $device,
    remounts => true,
  }
}
