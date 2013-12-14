#TODO: Add defined resource for CACHE and LOG (mirrored)
#TODO: Add defined resource for custom properties

define zfs::zpool (
    $ensure = 'present',
    $disk='',
    $log='',
    $mirror=[],
    $raid_parity='',
    $raidz=[],
    $spare='',
) {

    $pool = $title

    zpool { "$title":
        ensure => $ensure,
    }

    if $log !='' {
        Zpool <| title == $pool |> { log => $log }
    }
    if $disk !='' {
        Zpool <| title == $pool |> { disk => $disk }
    }
    if $mirror !=[] {
        Zpool <| title == $pool |> { mirror => $mirror }
    }
    if $raid_parity !='' {
        Zpool <| title == $pool |> { raid_parity => $raid_parity }
    }
    if $raidz !=[] {
        Zpool <| title == $pool |> { raidz => $raidz }
    }
    if $spare !='' {
        Zpool <| title == $pool |> { spare => $spare }
    }
}
