#defined type for system files
define files::tidy (
  $matches,
){
  tidy { $title:
    recurse => true,
    matches => $matches,
    rmdirs  => false,
  }
}

