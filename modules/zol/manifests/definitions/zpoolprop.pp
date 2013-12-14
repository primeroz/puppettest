define zol::zpoolprop (
    $propvalue = '',
    $poolname = '',
) {

    $propname = $title

    validate_string($poolname)
    validate_string($propname)

    if $propvalue == '' { fail("Property ${propname} need value") }
    if $poolname == '' { fail("Poolname must be specified for property set") }

    case $::osfamily {
        'Redhat': {
            $path_real = "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
        }
    }

    exec { "zpool_${poolname}_set_${propname}":
        path    => $path_real,
        command => "zpool set ${propname}=${propvalue} ${poolname}",
        unless  => "zpool list -H -o ${propname} ${poolname} | egrep \"$propvalue\""
    }
}

