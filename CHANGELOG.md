## 2.0.2 - 2016-08-29
- remove Ubuntu 15.04 support as it is EOL
- add Oracle Linux 5, 6, 7 support

## 2.0.1 - 2016-08-16
- remove explicit fedora support. it should still work but no one seems to use
  ksplice on fedora and puppet support for new versions of fedoras has lagged
  behind in the past
- remove Debian 6 support as it is EOL
- add support for Ubuntu 16.04
- add beaker tests

## 2.0.0 - 2015-11-10
- remove 'repo_ensure' parameter
- add 'repo_desc' parameter
- add 'repo_install' parameter
- add 'cron_install' parameter
- bump stdlib version requirement to 2.0.0
- add Travis CI testing
- puppet >= 3.2.0 and < 5.0.0 are officially supported

## 1.0.0 - 2015-10-12
- paramaterize the repos and package version

## 0.2.0 - 2015-08-27
- switch to Apache-2.0 license
- improve readability of facts and and only run them if the uptrack-uname binary
  exists

## 0.1.0 - 2015-08-18
- initial release
