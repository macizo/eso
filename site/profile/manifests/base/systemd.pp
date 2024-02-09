#class for systemd
#hiera parameters:
#systemd::dropin_files
#systemd::logind_settings
#systemd::journald_settings
#uses systemd module
class profile::base::systemd {
  # class {'systemd':
  #   dropin_files      => lookup('systemd::dropin_files'),
  #   logind_settings   => lookup('systemd::logind_settings'),
  #   journald_settings => lookup('systemd::journald_settings'),
  # }
  include systemd
}
