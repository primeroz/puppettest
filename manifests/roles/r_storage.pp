
class r_storage {

    class { 'zol': }

    #    $zolyaml = loadyaml("/etc/puppet/data/nodes/${::fqdn}.yaml")
    #    $pools_defaults = {
    #	require => Class['zol'],
    #    }
    #    $zfs_defaults = {
    #	require => Class['zol'],
    #    }
    #
    #    create_resources(zol::zpool,$zolyaml[zpool],$pools_defaults)
    #    create_resources(zol::zfs,$zolyaml[zfs],$zfs_defaults)

    anchor { 'r_storage::begin': }
    anchor { 'r_storage::end': }

    Anchor['r_storage::begin'] -> Class['zol']
        -> Anchor['r_storage::end']

}

