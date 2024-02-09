#role for oracle
class role::prod_oracle {
  include profile::base::dirs
  include profile::base::motd
  include profile::base::packages
  include profile::base::latest
  include profile::base::groups
  include profile::base::files
  include profile::base::system_users #before ssh_keys
  include profile::base::ssh_users
  include profile::base::ssh_keys
  include profile::base::sudo
  include profile::base::tidy
  include profile::base::cron
  include profile::base::systemd
  include profile::base::dns
  include profile::base::timesync
  include profile::cis::mounts
  include profile::cis::packages
  include profile::cis::permissions
  include profile::cis::replace_lines
  include profile::cis::scripts
  include profile::cis::services
  include profile::cis::sysctl
  include profile::cis::kmod
  include profile::cis::cis
  include profile::cis::auditd
  include profile::cis::pam
  include profile::cis::grub
# include profile::cis::aide
  include profile::base::dns
  # include profile::oracle::oracle #misc stuff that didn't go anywhere else
}
