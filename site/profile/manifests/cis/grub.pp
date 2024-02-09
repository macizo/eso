#set the grub paramters for RHEL
class profile::cis::grub (
) {
    kernel_parameter { 'audit_backlog_limit': value => '8192' }
}
