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

  $repo_name                = $ksplice::params::repo_name,
  $repo_yum_baseurl_prefix  = $ksplice::params::repo_yum_baseurl_prefix,
  $repo_apt_location        = $ksplice::params::repo_apt_location,
  $repo_enabled             = $ksplice::params::repo_enabled,
  $repo_gpgcheck            = $ksplice::params::repo_gpgcheck,
  $repo_gpgkey              = $ksplice::params::repo_gpgkey,
  $repo_key_id              = $ksplice::params::repo_key_id,
  $repo_key_source          = $ksplice::params::repo_key_source,

  $package_ensure           = $ksplice::params::package_ensure,

  ) inherits ksplice::params {
    validate_string($config_template)
    validate_string($config_accesskey)
    validate_bool($config_install_on_reboot)
    validate_bool($config_upgrade_on_reboot)
    validate_bool($config_autoinstall)

    validate_string($repo_name)
    validate_string($repo_yum_baseurl_prefix)
    validate_string($repo_apt_location)
    validate_bool($repo_enabled)
    validate_bool($repo_gpgcheck)
    validate_string($repo_gpgkey)
    validate_string($repo_key_id)
    validate_string($repo_key_source)

    validate_string($package_ensure)

    class{'::ksplice::repo':} ->
    class{'::ksplice::install':} ->
    class{'::ksplice::config':} ->
    class{'::ksplice::cron':}
}
