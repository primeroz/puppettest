class base::fw (
  $manage_firewall = false,
  ){

  if $base::fw::manage_firewall {
    # metatype to purge unmanaged firewall resources
	  resources { "firewall":
	    purge => true
	  }

	  Firewall {
	    before  => Class['base::fw::post'],
	    require => Class['base::fw::pre'],
	  }

	  class { ['base::fw::pre', 'base::fw::post']: }
	  class { 'firewall': }
  }
}


class base::fw::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }->
  firewall { '020 accept Inbound SSH':
    proto   => 'tcp',
    dport   => '22',
    state   => 'NEW',
    action  => 'accept',
  }
}

class base::fw::post {
  firewall { '999 drop all':
    proto   => 'all',
    action  => 'drop',
    before  => undef,
  }
}
