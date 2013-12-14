#TODO: Add Anchor and Ordering

class   r_apacheserver   {

    class { 'apache':
        default_mods => false,
        serveradmin  => "fc@pr-z.info",
        servername   => "puppet1.pr-z.info",
    }

}
