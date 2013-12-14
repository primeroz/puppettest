class base::hosts (
  $hosts    =   '',
  ) {

  $hosts_default = {
    ensure => 'present',
  }

  if ($base::hosts::hosts != '') {
    validate_hash($base::hosts::hosts) 
    create_resources(host,$hosts,$hosts_default)
  }

}
