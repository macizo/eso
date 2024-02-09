#node definitions

node 'hm-sis-t-puppet-test.esec.adm'{
   notify {'role':
    message =>  'eso_prod',
  }
  include role::eso_prod
}

node /^(hm|r5)-nid-t-sec-1-(vlog|vpca).esec.nid.test$/{
  notify {'role':
    message =>  'test nid RHEL 6',
  }
  include role::nid_test_rhel6
}
node 'hm-sis-d-ife-1-vrpsis.esec.sis.dev'{
  notify {'role':
    message =>  'test sis RHEL 6',
  }
  include role::sis_dev_rhel6
}

node /^(hm|r5)-(sis|ide)-(dev|d)-sec-(1|2|3|4|5)-(vtsapp|vtiapp|vtsci).esec.sis.dev$/{
  notify {'role':
    message =>  'dev sis RHEL 7',
  }
  include role::sis_dev_rhel7
}

node /^(hm|r5)-nid-kt-sec-(1|2)-(vlog|vpca|vica).esec.nid.pp$/{
  notify {'role':
    message =>  'pp nid RHEL 6',
  }
  include role::nid_pp_rhel6
}
node /^(hm|r5)-nid-kt-sec-(3|4|5)-vica.esec.nid.pp$/{
  notify {'role':
    message =>  'pp nid RHEL 7',
  }
  include role::nid_pp_rhel7
}

node /^(hm|r5)-nid-t-sec-(1|2|3|4|5)-(dev-)?(vica|vldap).esec.nid.test$/{
  notify {'role':
    message =>  'test nid RHEL 7',
  }
  include role::nid_test_rhel7
}

#ADM vrepodb oracle
node 'hm-eso-common-vrepodb.esec.test' {
  notify {'role':
    message =>  'test oracle',
  }
  include role::test_oracle
}

node /^hm-eso-(p-)*common-(3-vcapsule|mgmt).esec.prod$/ {
  notify {'role':
    message =>  'eso prod',
  }
  include role::eso_prod
}

node 'no1-sis-dev-vtrustdb.esec.sis.dev' {
  notify {'role':
    message =>  'dev oracle',
  }
  include role::dev_oracle
}

node 'hm-sis-dev-sec-2-vtrustdb.esec.sis.dev' {
  notify {'role':
    message =>  'dev oracle',
  }
  include role::dev_oracle
}

node /^(hm|no2)-(eso)-(t-sec|common)-(1|2)-(gitlab|mgmt).esec.test$/{
  notify {'role':
    message => 'eso role',
  }
  include role::eso
}

#node 'hm-eso-dev-splunk-4-sh.esec.dev'{
node /^(hm)-(eso)-(dev)-(splunk)-(1|2|3|4)-(dep|ds|idx|sh|vife).esec.dev$/{
  notify {'role':
    message => 'eso dev role',
  }
  include role::eso_dev
}

#SIS test oracle
node /^(hm|r5|no2)-(sis|es)-t-(vtrustdb|sec-(1|3)-vtrustdb).esec.sis.test$/{
  notify {'role':
    message =>  'test oracle',
  }
  include role::test_oracle
}

#SIS test tomcat
node /^(hm|r5)-(sis|ide)-t-sec-(3|4|5)-(vtsapp|vtiapp).esec.sis.test$/{
  notify {'role':
    message =>  'test tomcat',
  }
  include role::test_tomcat
}

#SIS preprod tomcat
node /^(hm|r5)-(sis|ide)-pp-sec-(3|4|5)-(vtsapp|vtiapp).esec.sis.pp$/{
  notify {'role':
    message =>  'preprod tomcat',
  }
  include role::pp_tomcat
}

#SIS prod tomcat
node /^(hm|r5)-(sis|ide)-p-sec-(3|4|5|6)-(vtsapp|vtiapp).esec.sis.prod$/{
  notify {'role':
    message =>  'prod tomcat',
  }
  include role::prod_tomcat
}

#SIS preprod oracle
node /^(hm|r5|no2)-(sis|es)-pp-(vtrustdb|sec-(1|3)-vtrustdb).esec.sis.pp$/{
  notify {'role':
    message =>  'preprod oracle',
  }
  include role::pp_oracle
}

#SIS prod oracle
node /^(hm|r5|no2)-(sis|es)-t-(vtrustdb|sec-(1|3)-vtrustdb).esec.sis.prod$/{
  notify {'role':
    message =>  'prod oracle',
  }
  include role::prod_oracle
}

