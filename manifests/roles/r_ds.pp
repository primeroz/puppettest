class r_ds (
  $suffix = '',
  $rootpw = '',
  $sync_binddn = '',
  ) {

}

class r_ds::master (
  $suffix = $r_ds::suffix,
  $rootpw = $r_ds::rootpw,
  $sync_binddn = $r_ds::sync_binddn,
  ) inherits r_ds {

  class { 'ldap::server::master':
    suffix      => $r_ds::master::suffix,
    rootpw      => $r_ds::master::rootpw,
    syncprov    => true,
    sync_binddn => $r_ds::master::sync_binddn,
    modules_inc => [ 'syncprov' ],
    #schema_inc  => [ 'gosa/samba3', 'gosa/gosystem' ],
    index_inc   => [
      'index memberUid            eq',
      'index mail                 eq',
      'index givenName            eq,subinitial',
      ],
  }


  class { 'apache':
          default_mods => false,
          serveradmin  => "fc@pr-z.info",
          servername   => "${::fqdn}",
          user         => "asterisk",
          group        => "asterisk",
        }..
  class { 'apache::mod::status':}.
  class { 'apache::mod::info':}
  class { 'apache::mod::dir':}
  class { 'apache::mod::mime':}
  class { 'apache::mod::mime_magic':}
  class { 'apache::mod::php':}.


  anchor { 'r_ds::begin': }
  anchor { 'r_ds::end': }

  Anchor['r_ds::begin'] 
  -> Class['ldap::server::master']
  -> Class['apache']
  -> Anchor['r_ds::end']

}

