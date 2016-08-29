class ksplice::repo {
  if $ksplice::repo_install {
    case $::operatingsystem {
      'CentOS', 'RedHat', 'OracleLinux', 'Fedora': {

        # convert the various operating systems to the names the ksplice-uptrack repo uses
        $os = $::operatingsystem ? {
          'CentOS'      => 'centos',
          'RedHat'      => 'rhel',
          'Fedora'      => 'fedora',
          'OracleLinux' => 'ol',
        }

        yumrepo {$ksplice::repo_name:
          baseurl  => "${ksplice::repo_yum_baseurl_prefix}/${os}/\$releasever/\$basearch/",
          descr    => $ksplice::repo_descr,
          enabled  => bool2num($ksplice::repo_enabled),
          gpgcheck => bool2num($ksplice::repo_gpgcheck),
          gpgkey   => $ksplice::repo_gpgkey,
        }
      }
      'Debian', 'Ubuntu': {
        include ::apt
        apt::source {$ksplice::repo_name:
          location => $ksplice::repo_apt_location,
          repos    => $ksplice::repo_name,
          key      => {
            'id'     => $ksplice::repo_key_id,
            'source' => $ksplice::repo_key_source,
          }
        }
        Class['apt::update'] -> Class['ksplice::install']
      }
      default: {
        fail("${::operatingsystem} not supported")
      }
    }
  }
}
