class ksplice::cron {

  # the uptrack package installs /etc/cron.d/uptrack by default but we manage
  # the cron job with puppet instead
  file {'/etc/cron.d/uptrack':
    ensure => 'absent',
  }

  cron {'ksplice':
    command  => 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin: uptrack-upgrade --cron',
    minute   => $ksplice::cron_minute,
    hour     => $ksplice::cron_hour,
    month    => $ksplice::cron_month,
    monthday => $ksplice::cron_monthday,
    weekday  => $ksplice::cron_weekday,
  }
}
