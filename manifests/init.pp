# == Class: ksplice
#
# Full description of class ksplice here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'ksplice':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class ksplice (

  $config_template          = $ksplice::params::config_template,
  $config_accesskey         = $ksplice::params::config_accesskey,
  $config_install_on_reboot = $ksplice::params::config_install_on_reboot,
  $config_upgrade_on_reboot = $ksplice::params::config_upgrade_on_reboot,
  $config_autoinstall       = $ksplice::params::config_autoinstall,

  $cron_minute              = $ksplice::params::cron_minute,
  $cron_hour                = $ksplice::params::cron_hour,
  $cron_month               = $ksplice::params::cron_month,
  $cron_monthday            = $ksplice::params::cron_monthday,
  $cron_weekday             = $ksplice::params::cron_weekday,

  ) inherits ksplice::params {


    class{'::ksplice::repo':} ->
    class{'::ksplice::install':} ->
    class{'::ksplice::config':} ->
    class{'::ksplice::cron':}
}
