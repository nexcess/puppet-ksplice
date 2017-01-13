require 'spec_helper'

describe 'ksplice' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        it { should contain_class('ksplice') }
        it { should contain_class('ksplice::params') }
        it { should contain_class('ksplice::repo') }
        it { should contain_class('ksplice::install') }
        it { should contain_class('ksplice::config') }
        it { should contain_class('ksplice::cron') }

        describe "ksplice::repo" do
          case facts[:osfamily]
          when 'RedHat'
            it { should contain_yumrepo('ksplice').with_descr('ksplice') }
            it { should contain_yumrepo('ksplice').with_enabled(1) }
            it { should contain_yumrepo('ksplice').with_gpgcheck(1) }
            it { should contain_yumrepo('ksplice').with_gpgkey('https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice') }

            case facts[:operatingsystem]
            when 'CentOS'
              it { should contain_yumrepo('ksplice').with_baseurl("http://www.ksplice.com/yum/uptrack/centos/$releasever/$basearch/") }
            when 'RedHat'
              it { should contain_yumrepo('ksplice').with_baseurl("http://www.ksplice.com/yum/uptrack/rhel/$releasever/$basearch/") }
            when 'Fedora'
              it { should contain_yumrepo('ksplice').with_baseurl("http://www.ksplice.com/yum/uptrack/fedora/$releasever/$basearch/") }
            when 'OracleLinux'
              it { should contain_yumrepo('ksplice').with_baseurl("http://www.ksplice.com/yum/uptrack/ol/$releasever/$basearch/") }
            end

            describe 'allow custom name' do
              let(:params) { {:repo_name => 'lsplice' } }
              it { should contain_yumrepo('lsplice') }
            end
            describe 'allow custom repo_yum_baseurl_prefix' do
              let(:params) { {:repo_yum_baseurl_prefix => 'http://mirror.example.com/ksplice/' } }
              it { should contain_yumrepo('ksplice').with_basurl =~ %r{^http://mirror.example.com/ksplice/} }
            end

            describe 'allow custom description' do
              let(:params) { {:repo_descr => 'lsplice' } }
              it { should contain_yumrepo('ksplice').with_descr('lsplice') }
            end

            describe 'allow custom enabled' do
              let(:params) { {:repo_enabled => false } }
              it { should contain_yumrepo('ksplice').with_enabled(0) }
            end

            describe 'allow custom gpgcheck' do
              let(:params) { {:repo_gpgcheck => false } }
              it { should contain_yumrepo('ksplice').with_gpgcheck(0) }
            end

            describe 'allow custom gpgkey' do
              let(:params) { {:repo_gpgkey => 'https://mirror.example.com/ksplice/yum/RPM-GPG-KEY-ksplice' } }
              it { should contain_yumrepo('ksplice').with_gpgkey('https://mirror.example.com/ksplice/yum/RPM-GPG-KEY-ksplice') }
            end

            describe 'allow repo_install = false' do
              let(:params) { {:repo_install => false } }
              it { should_not contain_yumrepo('ksplice') }
            end
          when 'Debian'
            it { should contain_apt__source('ksplice').with_location('http://www.ksplice.com/apt/') }
            it { should contain_apt__source('ksplice').with_repos('ksplice') }
            it { should contain_apt__source('ksplice').with_key('id' => '5DE2D4F255E23055D3C40F2CF7CA6265B6D4038E', 'source' => 'https://www.ksplice.com/apt/ksplice-archive.asc') }

            describe 'allow custom name' do
              let(:params) { {:repo_name => 'lsplice' } }
              it { should contain_apt__source('lsplice') }
            end
            describe 'allow custom key id and source' do
              let(:params) { {:repo_key_id => 'ABCD1234', :repo_key_source => 'https://example.com/key.asc' } }
              it { should contain_apt__source('ksplice').with_key('id' => 'ABCD1234', 'source' => 'https://example.com/key.asc') }
            end
            describe 'allow repo_install = false' do
              let(:params) { {:repo_install => false } }
              it { should_not contain_apt__source('ksplice') }
            end
          end
        end

        describe "ksplice::install" do
          it { should contain_package('uptrack') }
          describe 'allow custom version' do
            let(:params) { {:package_ensure => '1.2.3' } }
            it { should contain_package('uptrack').with_ensure('1.2.3') }
          end
        end

        describe "ksplice::cron" do
          it { should contain_file('/etc/cron.d/uptrack').with_ensure('absent') }
          it { should contain_cron('ksplice').with_command('PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin: uptrack-upgrade --cron' ) }
          #it { should contain_cron('ksplice').with_minute() }
          it { should contain_cron('ksplice').with_hour('*') }
          it { should contain_cron('ksplice').with_month('*') }
          it { should contain_cron('ksplice').with_monthday('*') }
          it { should contain_cron('ksplice').with_weekday('*') }

          describe 'allow custom cron minute' do
            let(:params) { {:cron_minute => '0,15,30,45' } }
            it { should contain_cron('ksplice').with_minute('0,15,30,45') }
          end

          describe 'allow custom cron hour' do
            let(:params) { {:cron_hour => '3' } }
            it { should contain_cron('ksplice').with_hour('3') }
          end

          describe 'allow custom cron month' do
            let(:params) { {:cron_month => '14' } }
            it { should contain_cron('ksplice').with_month('14') }
          end

          describe 'allow custom cron monthday' do
            let(:params) { {:cron_monthday => '15' } }
            it { should contain_cron('ksplice').with_monthday('15') }
          end

          describe 'allow custom cron weekday' do
            let(:params) { {:cron_weekday => '4' } }
            it { should contain_cron('ksplice').with_weekday('4') }
          end

          describe 'allow cron_install = false' do
            let(:params) { {:cron_install => false } }
            it { should_not contain_cron('ksplice') }
          end

        end

        describe "ksplice::config" do
          it { should contain_file('/etc/uptrack/uptrack.conf').with_owner('root') }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_group('root') }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_mode('0640') }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/accesskey = INSERT_ACCESS_KEY/) }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/https_proxy = None/) }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/install_on_reboot = yes/) }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/upgrade_on_reboot = yes/) }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/autoinstall = yes/) }

          describe 'allow custom template' do
            let(:params) { {:config_template => 'custom_templates/uptrack.conf.erb' } }
            it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/herp-a-derp/) }
          end

          describe 'set accesskey' do
            let(:params) { {:config_accesskey => 'deadbeef'} }
            it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/accesskey = deadbeef/) }
          end

          describe 'disable install_on_reboot' do
            let(:params) { {:config_install_on_reboot => false } }
            it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/install_on_reboot = no/) }
          end

          describe 'disable upgrade_on_reboot' do
            let(:params) { {:config_upgrade_on_reboot => false } }
            it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/upgrade_on_reboot = no/) }
          end

          describe 'disable autoinstall' do
            let(:params) { {:config_autoinstall => false } }
            it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/autoinstall = no/) }
          end
        end
      end
    end
  end
end

