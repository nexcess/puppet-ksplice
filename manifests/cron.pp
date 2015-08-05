class ksplice::cron inherits ksplice {

  # the uptrack package installs /etc/cron.d/uptrack by default but we manage
  # the cron job with puppet instead
  file {'/etc/cron.d/uptrack':
    ensure => 'absent',
  }

  cron {'ksplice':
    command  => 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin: uptrack-upgrade --cron',
    minute   => $cron_minute,
    hour     => $cron_hour,
    month    => $cron_month,
    monthday => $cron_monthday,
    weekday  => $cron_weekday,
  }
}
