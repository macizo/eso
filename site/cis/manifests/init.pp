#class implementing CIS guidelines
class cis {

  service { 'sshd':
    ensure  => 'running',
  }
  #template for sshd_config
  $sshd_config_hash = {
    'allow_groups'           =>  lookup('profile::cis::allow_groups', Array, 'unique'),
    'password_enabled'       =>  lookup('profile::base::password_enabled'),
  }

  if ($facts['os']['release']['major'] < '7') {
    file { '/etc/ssh/sshd_config':
      content => epp('cis/sshd_config_rhel6.epp',$sshd_config_hash),
      notify  => Service['sshd'],
      mode    => '0600',
      owner   => 'root',
      group   => 'root',
    }
  }
  else {
    file { '/etc/ssh/sshd_config':
      content => epp('cis/sshd_config.epp',$sshd_config_hash),
      notify  => Service['sshd'],
      mode    => '0600',
      owner   => 'root',
      group   => 'root',
    }
  }
}
