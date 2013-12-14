class base::hosts (
  $hosts    =   '',
  ) {

  $hosts_default = {
    ensure => 'present',
  }

  if ($base::hosts::hosts != '') and validate_hash($base::hosts::hosts) {
    create_resources(host,$hosts,$hosts_default)
  }

}
