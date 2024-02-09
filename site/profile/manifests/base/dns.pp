#replace dns settings
class profile::base::dns {
  lookup(profile::base::dns).each |$line| {
    common::replace_line { $line['title']:
      path  => $line['path'],
      line  => $line['line'],
      match => $line['match'],
    }
  }
  # restart network
  service { 'NetworkManager':
    ensure    => running,
    enable    => true,
    subscribe => File_line['dns1', 'dns2', 'search'],
  }
}
