# Class: profile::base::cron
#does a lookup for the cron::job and cron::job::multiple keys in hiera
class profile::base::cron {
  # resources
  include cron
}
