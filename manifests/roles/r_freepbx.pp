
class   r_freepbx (
                  $root_dbpassword = '',
                  $virt_users = [],
                  ) {

    realize(Users::Account['fc'])

    class { 'apache':
        default_mods => false,
        serveradmin  => "fc@pr-z.info",
        servername   => "${::fqdn}",
        user         => "asterisk",
        group        => "asterisk",
    }  
    class { 'apache::mod::status':} 
    class { 'apache::mod::info':}
    class { 'apache::mod::dir':}
    class { 'apache::mod::mime':}
    class { 'apache::mod::mime_magic':}
    class { 'apache::mod::php':} 

    class { 'mysql::server':
        config_hash => {'root_password' => $r_freepbx::root_dbpassword}
    }
    class { 'mysql::server::account_security': }

    class { 'freepbx': 
    }


    #TODO: Add Anchor and Ordering
    Class['apache']->Class['mysql::server']->Class['freepbx']

}

