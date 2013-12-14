#TODO: manage ensure (present|absent|whatever)
#TODO: manage zfs properties

define zol::zfs (
    $ensure = present,
    $poolname = '',
    $zfsname = '',
    $prop_mountpoint = '',
    $prop_mounted = 'yes',
    $prop_recordsize = '128K',
    $prop_atime = 'on',
    $prop_compression = 'off',
    $prop_dedup = 'off',

) {

    if $poolname == '' { fail("POOLNAME need to be specified to create a new ZFS") }

    if $zfsname == '' {
        $zfsname_real = $title
    }
    else {
        $zfsname_real = $zfsname
    }

    if $prop_mountpoint == '' {
        $prop_mountpoint_real = "/${poolname}/${zfsname_real}"
    }
    else {
        $prop_mountpoint_real = $prop_mountpoint
    }

    validate_string($poolname)
    validate_string($zfsname_real)
    validate_re($prop_mounted,['^yes$','^no$'])

    case $::osfamily {
        'Redhat': {
            $path_real = "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
        }
    }

    Exec { path => $path_real }

    Zol::Zfsprop {
        poolname  => $poolname,
        zfsname   => $zfsname_real,
    }


    exec { "zfs_${poolname}_${zfsname_real}_create":
        command => "zfs create ${poolname}/${zfsname_real}",
        unless  => "zfs list -H ${poolname}/${zfsname_real}",
        require => Zol::Zpool[$poolname],
    } ->
    zol::zfsprop { "${poolname}_${zfsname_real}_compression":
	propname  => "compression",
        propvalue => $prop_compression,
    } ->
    zol::zfsprop { "${poolname}_${zfsname_real}_dedup":
	propname  => "dedup",
        propvalue => $prop_dedup,
    } ->
    zol::zfsprop { "${poolname}_${zfsname_real}_atime":
	propname  => "atime",
        propvalue => $prop_atime,
    } ->
    zol::zfsprop { "${poolname}_${zfsname_real}_mounted":
	propname  => "mounted",
        propvalue => $prop_mounted,
    } ->
    zol::zfsprop { "${poolname}_${zfsname_real}_mountpoint":
	propname  => "mountpoint",
        propvalue => $prop_mountpoint_real,
    }


}

