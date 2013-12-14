#TODO: manage ensure (present|absent|whatever)
#TODO: manage zpool properties

define zol::zpool (
    $ensure = present,
    $poolname = '',
    $pooltype = 'raidz1',
    $pooldisks = [],
    $poolforce = false,
    $prop_ashift = 0,
    $prop_autoexpand = 0

) {

    if $poolname == '' {
        $poolname_real = $title
    }

    validate_string($poolname_real)
    validate_re($pooltype,['^none$','^mirror$','^raidz[1-3]$'])
    validate_array($pooldisks)

    # Build the ZPOOL arraystring based on type and vdevs list/s
    $arraystring = arraystring_zpool($pooltype,$pooldisks)
    
    case $::osfamily {
        'Redhat': {
            $path_real = "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
        }
    }

    if $poolforce {
        $zpool_cmd = "zpool create -f ${poolname_real} ${arraystring}"
    }
    else {
        $zpool_cmd = "zpool create ${poolname_real} ${arraystring}"
    }

    exec { "zpool_${poolname_real}_create":
        path    => $path_real,
        command => $zpool_cmd,
        unless  => "zpool list -H -o health ${poolname_real}"
    } 

}

