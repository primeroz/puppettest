class base::hosts (
  $hosts    =   '',
  ) {

  $bool_hosts=array2bool($hosts)

  $hosts_default = {
    ensure => 'present',
  }

  if $base::hosts::bool_hosts {
    validate_hash($hosts)
    create_resources(host,$hosts,$hosts_default)
  }

}
