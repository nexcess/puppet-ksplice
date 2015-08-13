class ksplice::repo {
  case $operatingsystem {
    'CentOS', 'RedHat', 'Fedora': {

      # convert the various operating systems to the names the ksplice-uptrack repo uses
      $os = $::operatingsystem ? {
        'CentOS' => 'centos',
        'RedHat' => 'rhel',
        'Fedora' => 'fedora',
      }

      yumrepo {'ksplice-uptrack':
        ensure   => 'present',
        baseurl  => "http://www.ksplice.com/yum/uptrack/${os}/\$releasever/\$basearch/",
        enabled  => '1',
        gpgcheck => '1',
        gpgkey   => 'https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice',
      }
    }
    'Debian', 'Ubuntu': {
      include ::apt
      apt::source {'ksplice':
        ensure   => 'present',
        location => 'http://www.ksplice.com/apt/',
        repos    => 'ksplice',
        key      => {
          'id'      => '5DE2D4F255E23055D3C40F2CF7CA6265B6D4038E',
          'source'  => 'https://www.ksplice.com/apt/ksplice-archive.asc',
        }
      }
      Class['apt::update'] -> Class['ksplice::install']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
