class ksplice::params {
  $config_template          = 'ksplice/uptrack.conf.erb'
  $config_accesskey         = 'INSERT_ACCESS_KEY'
  $config_install_on_reboot = true
  $config_upgrade_on_reboot = true
  $config_autoinstall       = true

  $cron_minute              = [fqdn_rand(30) , fqdn_rand(30) + 30]
  $cron_hour                = '*'
  $cron_month               = '*'
  $cron_monthday            = '*'
  $cron_weekday             = '*'
}
