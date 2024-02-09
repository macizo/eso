#replace a line in file
define common::replace_line (
  $line,
  $match,
  $path,
){
  file_line { $title:
    path    => $path,
    replace => true,
    line    => $line,
    match   => $match,
  }
}
