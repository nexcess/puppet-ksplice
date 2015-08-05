class ksplice::repo {

  $os = $operatingsystem ? {
    'CentOS' => 'centos',
    'RedHat' => 'rhel',
    'Fedora' => 'fedora',
  }

  yumrepo {'ksplice-uptrack':
    ensure   => 'present',
    baseurl  => "http://www.ksplice.com/yum/uptrack/$os/\$releasever/\$basearch/",
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice',
  }
}
