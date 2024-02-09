#role for nemid test
class role::nid_test_rhel7 {
  include profile::base::dirs
  include profile::base::motd
  include profile::base::packages
  include profile::base::groups
  include profile::base::ssh_users
  include profile::base::system_users #before ssh_keys
  include profile::base::ssh_keys
  include profile::base::sudo
  include profile::base::files
  include profile::base::cron
  include profile::base::tidy
  include profile::base::systemd
  include profile::base::timesync
  include profile::cis::pam
  include profile::cis::mounts
  include profile::cis::permissions
  include profile::cis::replace_lines
  include profile::cis::scripts
  include profile::cis::services
  include profile::cis::sysctl
  include profile::cis::kmod
  include profile::cis::cis
  include profile::cis::auditd
  include profile::cis::grub
  # include profile::cis::aide
}
