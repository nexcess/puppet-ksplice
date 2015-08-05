require 'spec_helper'

describe 'ksplice' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { should contain_class('ksplice::params') }
        it { should contain_class('ksplice::repo') }
        it { should contain_class('ksplice::install') }
        it { should contain_class('ksplice::config') }
        it { should contain_class('ksplice::cron') }

        describe "ksplice::repo" do
          case facts[:operatingsystem]
          when 'CentOS'
            it { should contain_yumrepo('ksplice-uptrack').with_baseurl("http://www.ksplice.com/yum/uptrack/centos/$releasever/$basearch/") }
          when 'RedHat'
            it { should contain_yumrepo('ksplice-uptrack').with_baseurl("http://www.ksplice.com/yum/uptrack/rhel/$releasever/$basearch/") }
          when 'Fedora'
            it { should contain_yumrepo('ksplice-uptrack').with_baseurl("http://www.ksplice.com/yum/uptrack/fedora/$releasever/$basearch/") }
          end
          it { should contain_yumrepo('ksplice-uptrack').with_enabled('1') }
          it { should contain_yumrepo('ksplice-uptrack').with_gpgcheck('1') }
          it { should contain_yumrepo('ksplice-uptrack').with_gpgkey('https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice') }
        end

        describe "ksplice::install" do
          it { should contain_package('uptrack') }
        end

        describe "ksplice::cron" do
          it { should contain_file('/etc/cron.d/uptrack').with_ensure('absent') }
          it { should contain_cron('ksplice').with_command('PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin: uptrack-upgrade --cron' ) }
          it { should contain_cron('ksplice').with_minute(/[0-9]{1,2},[0-9]{1,2}/) }
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

        end

        describe "ksplice::config" do
          it { should contain_file('/etc/uptrack/uptrack.conf').with_owner('root') }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_group('root') }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_mode('0640') }
          it { should contain_file('/etc/uptrack/uptrack.conf').with_content(/accesskey = INSERT_ACCESS_KEY/) }
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

