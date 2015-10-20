# ksplice

[![Travis](https://img.shields.io/travis/nexcess/puppet-ksplice.svg)](https://travis-ci.org/nexcess/puppet-ksplice)
[![Puppet Forge](https://img.shields.io/puppetforge/v/nexcess/ksplice.svg)](https://forge.puppetlabs.com/nexcess/ksplice)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description ](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference ](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Copyright](#copyright)

## Overview

This module installs, configures, and manages ksplice for rebootless kernel upgrades.

## Module Description


The ksplice module installs, configures, and manages
[ksplice](http://ksplice.oracle.com/) to update your kernel without needing to
reboot.

A license/access key from ksplice is required for rebootless upgrades to work.

The module will install the ksplice repository, install the uptrack package, and
manage the ksplice configuration file.

## Usage

### Beginning with ksplice
If you have a license key and want to check for kernel updates every 30 minutes and automatically install them. This is what the normal manual installation of ksplice will do.

```
class { '::ksplice':
  config_accesskey => 'YOUR_LICENSE_KEY',
}
```


### Custom cron times

By default uptrack runs every 30 minutes unless you give it a custom cron time.

```
class { '::ksplice':
  config_accesskey	=> 'YOUR_LICENSE_KEY',
  cron_minute		=> '13',
  cron_hour			=> '03',
  cron_month		=> '*',
  cron_monthday		=> '*',
  cron_weekday		=> '*',
}
```

## Reference

### Classes

* ksplice::repo: Installs the package repository on the server
* ksplice::install: Installs the uptrack package on the server
* ksplice::config: Manages the configuration for uptrack
* ksplice::cron: Manages the cron job for uptrack


### Parameters

#### `config_template`
Specify a custom template to use. Default value: 'ksplice/uptrack.conf.erb'

#### `config_accesskey`
Specify your accesskey. Default value: 'INSERT_ACCESS_KEY'

#### `config_install_on_reboot`
Automatically install updates at boot time. If this is set, on reboot into the same kernel, uptrack will re-install the same set of updates that were present before the reboot. Default value: 'true'

#### `config_upgrade_on_reboot`
Automatically install all available updates at boot time, even if rebooted into a different kernel. Default value: 'true'

#### `config_autoinstall`
Uptrack runs in a cron job to check for and download new updates. You can can configure this cron job to automatically install new updates as they become available. Default value: 'true'

#### `cron_minute`
Specify a custom cron_minute. Default value: `[fqdn_rand(30) , fqdn_rand(30) + 30]`

#### `cron_hour`
Specify a custom cron_hour. Default value: '*'

#### `cron_month`
Specify a custom cron_month. Default value: '*'

#### `cron_monthday`
Specify a custom cron_monthday. Default value: '*'

#### `cron_weekday`
Specify a custom cron_weekday. Default value: '*'

#### `repo_name`
Specify a custom name for the yum and apt repo. Default value: 'ksplice'

#### `repo_desc`
Specify a custom description for the yum repo. Default value: 'ksplice'

#### `repo_yum_baseurl_prefix`
Specify a baseurl_prefix for the yum repo. It isn't documented anywhere but you can mirror the uptrack packages from ksplice.com using rsync. Default value: 'http://www.ksplice.com/yum/uptrack/'

#### `repo_apt_location`
Specify a baseurl_prefix for the yum repo. It isn't documented anywhere but you can mirror the uptrack packages from ksplice.com using rsync. Default value: 'http://www.ksplice.com/apt/'

#### `repo_enabled`
Specify the enable value for the yum and apt repo. Default value: true

#### `repo_gpgcheck`
Specify the gpgcheck value for the yum repo. Default value: true

#### `repo_gpgkey`
Specify a custom url or path for the GPG key for the packages in the yum repo. Default value: 'https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice'

#### `repo_key_id`
Specify a custom key id for the apt repo. Default value: '5DE2D4F255E23055D3C40F2CF7CA6265B6D4038E'

#### `repo_key_source`
Specify a custom url for the apt key. Default value: 'https://www.ksplice.com/apt/ksplice-archive.asc'

#### `package_ensure`
Specify a version of status for the uptrack package. Default value: 'present'

### Facts
`uptrack-uname` will print out the effective version of kernel after patching. It accepts uname(1) command-line options and produces compatible output. There are facts, using uptrack-uname, corresponding to the kernel facts that already come with facter.

* ksplice_kernelrelease: effective kernel release
* ksplice_kernelversion: effective kernel version
* ksplice_kernelmajversion: effective kernel major version
* ksplice_kernel_package_version: effective version of the distribution's kernel package

## Limitations

The module works with currently supported versions of CentOS, RHEL, Debian,
Ubuntu, and Fedora. It has been tested on CentOS, Debian, Ubuntu, and Fedora. It
can probably work on Oracle Linux and Scientific Linux with minimal work.

## Development

Install necessary gems:
```
bundle install --path vendor/bundle
```

Check syntax of all puppet manifests, erb templates, and ruby files:
```
bundle exec rake validate
```

Run puppetlint on all puppet files:
```
bundle exec rake lint
```

Run spec tests in a clean fixtures directory
```
bundle exec rake spec
```

Run acceptance tests with a ksplice license:
```
KSPLICE_LICENSE=abc123 BEAKER_setfile=spec/acceptance/nodesets/centos-66-x64.yml bundle exec rake acceptance
KSPLICE_LICENSE=abc123 BEAKER_setfile=spec/acceptance/nodesets/debian-610-x64.yml bundle exec rake acceptance
```

## Copyright

Copyright 2015 [Nexcess](https://www.nexcess.net/)

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
