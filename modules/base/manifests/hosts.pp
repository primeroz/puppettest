class base::hosts (
  $hosts    =   '',
  $self     = true,
  ) {

  $hosts_default = {
    ensure => 'present',
  }

  #Add entries from HIERA or passed parameters
  if ($base::hosts::hosts != '') {
    validate_hash($base::hosts::hosts) 
    create_resources(host,$hosts,$hosts_default)
  }

  #Add Entry for host itself
  if ($base::hosts::self) {
    host { ${::hostname}:
      ip = ${::ipaddress},
      host_aliases = ${::fqdn},
      ensure = 'present',
    }
  }
}
