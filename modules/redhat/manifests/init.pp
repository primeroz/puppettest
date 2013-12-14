# == Class: CentOS
#
# Full description of class CentOS here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { CentOS:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class redhat {

    # Define package list based on CentOS version
    case $::operatingsystemmajrelease {
        6: { $basepackages = ["tcpdump","tmux","yum-plugin-priorities"] }
    }

    # Define Epel Version based on CentOS version
    case $::operatingsystemmajrelease {
        6: { $epelvers = "epel-6" }
    }

    # Enable EPEL repo my mirrors
    yumrepo {
        "epel":
            descr          =>   "Epel Repository for CentOS",
            mirrorlist     =>   "http://mirrors.fedoraproject.org/mirrorlist?repo=${epelvers}&arch=\$basearch",
            failovermethod =>   "priority",
            gpgcheck       =>   "0",
            enabled        =>   "1";
    }

    package { $basepackages:
        ensure  =>  "installed",
        require =>  Yumrepo['epel']
    }

}
