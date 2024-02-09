#logrotate profile
class profile::sis::logrotate{
  include logrotate #uses logrotate::rules key in tomcat.yaml 
}
