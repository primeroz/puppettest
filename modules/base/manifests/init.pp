# == Class: base
#
# Full description of class base here.
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
#  class { base:
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
class base (
  $manage_firewall,
  ) {

    include "users"
    include "v_users"
    include "stdlib"

    include "${osfamily}"
    include "base::basedir"
    include "base::hosts"
    include "base::ntp"

    class { "base::fw": 
              manage_firewall => $base::manage_firewall,
          }

    include "base::motd"


    anchor { 'base::begin': }
    anchor { 'base::end': }

    Anchor['base::begin'] 
	-> Class["${osfamily}"]
	-> Class['base::basedir'] 
	-> Class['base::hosts'] 
  -> Class['base::ntp'] 
  -> Class['base::fw'] 
  -> Class['base::motd']
  -> Anchor['base::end']
}

class base::common (
  $manage_firewall = false,
  ) {

    realize(Users::Account['fc'])

    class {'base': 
            manage_firewall => $base::common::manage_firewall,
          }

    anchor { 'base::common::begin': }
    anchor { 'base::common::end': }

    Anchor['base::common::begin'] 
    -> Class['base']
    -> Anchor['base::common::end']
}
