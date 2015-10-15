source 'https://rubygems.org'

gem 'puppetlabs_spec_helper', '>= 0.8.2'
gem 'puppet-lint', '>= 1.0.0'
gem "rspec-puppet-facts"
gem "beaker"
gem "beaker-rspec"
gem "puppet-blacksmith"
gem "metadata-json-lint"

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

