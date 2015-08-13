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
    validate_string($config_template)
    validate_string($config_accesskey)
    validate_bool($config_install_on_reboot)
    validate_bool($config_upgrade_on_reboot)
    validate_bool($config_autoinstall)

    class{'::ksplice::repo':} ->
    class{'::ksplice::install':} ->
    class{'::ksplice::config':} ->
    class{'::ksplice::cron':}
}
