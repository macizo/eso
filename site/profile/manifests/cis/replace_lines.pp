#profile replacing the CIS lines 
class profile::cis::replace_lines {
  lookup(profile::cis::lines).each |$line| {
    common::replace_line { $line['title']:
      path  => $line['path'],
      line  => $line['line'],
      match => $line['match'],
    }
  }
}
