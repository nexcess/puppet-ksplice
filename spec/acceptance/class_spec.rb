require 'spec_helper_acceptance'

describe 'ksplice class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'ksplice': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end


    describe "ksplice::repo" do
      case fact('operatingsystem')
      when 'CentOS', 'RedHat', 'Fedora'
        describe yumrepo('ksplice') do
          it { is_expected.to exist }
          it { is_expected.to be_enabled }
        end
      end
    end

    describe "ksplice::install" do
      describe package('uptrack') do
        it { is_expected.to be_installed }
      end
    end

    describe "ksplice::config" do
      describe file('/etc/uptrack/uptrack.conf') do
        it { is_expected.to exist }
        it { is_expected.to be_mode(640) }
        it { is_expected.to be_owned_by('root') }
        it { is_expected.to be_grouped_into('root') }
        it { is_expected.to contain('accesskey = INSERT_ACCESS_KEY') }
        it { is_expected.to contain('https_proxy = None') }
        it { is_expected.to contain('install_on_reboot = yes') }
        it { is_expected.to contain('upgrade_on_reboot = yes') }
        it { is_expected.to contain('autoinstall = yes') }
      end
    end

    describe "ksplice::cron" do
      # describe cron('ksplice') do
      #   it { is_expected.to have_entry('PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin: uptrack-upgrade --cron' ).with_user('root')}
      # end

      describe file('/etc/cron.d/uptrack') do
        it { is_expected.to_not exist }
      end
    end

    if ! ENV['KSPLICE_LICENSE'].nil?
      context 'with a ksplice license' do
        # Using puppet_apply as a helper
        it 'should work idempotently with no errors' do
          pp = <<-EOS
          class { 'ksplice': config_accesskey=>#{ENV['KSPLICE_LICENSE']}}
          EOS

          # Run it twice and test for idempotency
          apply_manifest(pp, :catch_failures => true)
          apply_manifest(pp, :catch_changes  => true)
        end

        it 'should upgrade the kernel' do
          shell('/usr/sbin/uptrack-upgrade -y --all')
          shell(%q{test "$(uname -a)" != "$(uptrack-uname -a)"}, :acceptable_exit_codes => 0)
        end
      end
    end
  end
end

