# users, groups, configuration files for Oracle 
class oracle{
  #Calculate Oracle variables using the custom facts:
  #kernel.shmmax=(Half physical memory in bytes) $facts[mem_size] 
  #kernel.shmall=(kernel.shmmax / 4096 [Page Size]) 
  #Page size is retrieved by command getconf PAGE_SIZE ($facts[page_size])     

  $kernel_shmmax = ($facts[mem_size] * 1024) / 2
  $kernel_shmall =  $kernel_shmmax / $facts[page_size]
  $hugepages =  $facts[hugepages]

  $oracle_config_hash = {
    'kernel_shmall'   => $kernel_shmall,
    'kernel_shmmax'   => $kernel_shmmax,
    'hugepages'       => $hugepages,
  }

  # file { '/etc/sysctl.d/oracle.conf':
  #   mode    => '0755',
  #   owner   => 'root',
  #   group   => 'root',
  #   path    => '/etc/sysctl.d/oracle.conf',
  #   content => epp('oracle/sysctl_oracle.epp', $oracle_config_hash)
  # }

  # if ($hugepages != -1){
  #   exec { 'load-sysctl':
  #     command     => '/sbin/sysctl -p /etc/sysctl.d/oracle.conf',
  #     refreshonly => true
  #   }
  # }
# if ($hostname =~ /(hm|r5)-sis-t-sec-(1|3)-vtrustdb/){
  #   package { 'psmisc':
  #     ensure => 'installed',
  #   }
  # }\

  package { lookup('profile::oracle::pkgs'):
    ensure => present,
  }
}
