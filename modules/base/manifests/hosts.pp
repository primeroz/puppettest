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
    create_resources(host,$base::hosts::hosts,$base::hosts::hosts_default)
  }

  #Add Entry for host itself
  if ($base::hosts::self) {
    host { $::fqdn:
      ip            => $::ipaddress,
      host_aliases  => $::hostname,
      ensure        => 'present',
    }
  }
}
