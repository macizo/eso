# Testlab
class motd {

  # notify { "test_motd_${facts[os][name]}":
  #   message => "it is in test_motd_test_motd_${facts[os][name]}",
  # }

  if ($facts[os][name] == 'RedHat'){
    notify { 'test_motd_redhat':
      message => 'it is in test_motd_redhat',
    }

    file { '/etc/motd':
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      path    => '/etc/motd',
      content => template('motd/motd.erb')
    }
  } elsif ($facts[os][name] == 'SLES') {
      notify { 'test_motd_sles':
        message => 'it is in test_motd_sles',
      }
  }
}
