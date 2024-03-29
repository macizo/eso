# This define adds rules to the AIDE configuration. Rules are
# added to /etc/aide.conf.d unless otherwise specified.
#
# @example Rule to ignore changes to ``/tmp``
#
#   aide::rule { 'tmp':
#     rules => '!/tmp'
#   }
#
# @param name
#
# @param rules
#   The actual string that should be written into the rules file. Leading
#   spaces are stripped so that you can format your manifest in a more readable
#   fashion.
#
# @param ruledir
#   The directory within which all additional rules should be written. This
#   MUST be the same value as that entered in aide::conf if you want the system
#   to work properly.  Default: '/etc/aide.conf.d'
#
# @param order
#   Order of aide rules can be significant. This parameter can be used to
#   control the order of included rule files.
#
# @author https://github.com/simp/pupmod-simp-aide/graphs/contributors
#
define aide::rule (
  String               $rules,
  Stdlib::Absolutepath $ruledir = '/etc/aide.conf.d',
  String               $order = '999',
) {
  include 'aide'

  file { "${ruledir}/${name}.aide":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template('aide/rules.erb'),
    notify  => Exec['update_aide_db']
  }

  concat::fragment { "aide rule ${name}":
    target  => '/etc/aide.conf',
    content => "@@include ${ruledir}/${name}.aide\n",
    order   => $order,
  }

  if $aide::auditd {
    simplib::assert_optional_dependency($module_name, 'simp/auditd')

    # Add auditing rules for the aide configuration.
    auditd::rule { "${name}.aide":
      content => "-w ${ruledir}/${name}.aide -p wa -k CFG_aide"
    }
  }
}
