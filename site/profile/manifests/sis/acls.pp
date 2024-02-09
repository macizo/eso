# Class: profile::sis::acls
#adds ACLs for the bastian user in the logs directories
class profile::sis::acls {
  # resources
  fooacl::conf { 'sis logs':
    target      => [
      '/opt/service/logs/maintenance',
      '/opt/service/logs/archive',
    ],
    permissions => [
      'bastian:rwX',
    ],
  }
}
