class ksplice::config {
  file {'/etc/uptrack/uptrack.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("$ksplice::config_template")
  }
}
