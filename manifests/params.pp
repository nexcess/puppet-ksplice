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

  $repo_name                = 'ksplice'
  $repo_ensure              = 'present'
  $repo_yum_baseurl_prefix  = 'http://www.ksplice.com/yum/uptrack'
  $repo_apt_location        = 'http://www.ksplice.com/apt/'
  $repo_enabled             = true
  $repo_gpgcheck            = true
  $repo_gpgkey              = 'https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice'
  $repo_key_id              = '5DE2D4F255E23055D3C40F2CF7CA6265B6D4038E'
  $repo_key_source          = 'https://www.ksplice.com/apt/ksplice-archive.asc'

  $package_ensure           = 'present'
}
