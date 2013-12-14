define zol::zfsprop (
    $propname = '',
    $propvalue = '',
    $poolname = '',
    $zfsname = '',
) {

    if $propname == '' {
    	$propname_real = $title
    } else {
    	$propname_real = $propname
    }
	

    validate_string($poolname)
    validate_string($zfsname)
    validate_string($propname_real)

    if $propvalue == '' { fail("Property ${propname_real} need value") }
    if $zfsname == '' { fail("ZFSName must be specified to set property") }
    if $poolname == '' { fail("Poolname must be specified for property set") }

    case $::osfamily {
        'Redhat': {
            $path_real = "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
        }
    }

    exec { "zfs_${poolname}_${zfsname}_set_${propname_real}":
        path    => $path_real,
        command => "zfs set ${propname_real}=${propvalue} ${poolname}/${zfsname}",
        unless  => "zfs list -H -o ${propname_real} ${poolname}/${zfsname} | egrep \"$propvalue\""
    }
}

