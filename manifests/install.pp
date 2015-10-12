class ksplice::install {
  package {'uptrack':
    ensure => $ksplice::package_ensure,
  }
}
