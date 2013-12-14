define users::account (
    $ensure = "present",
    $fullname,
    $groups=[],
    $shell="/bin/bash",
    $password='',
    $managehome='true',
    $home="/home/$title",
) {
    $username=$title
    user { "$username":
        ensure     => $ensure,
        gid        => $username,
        groups     => $groups,
        comment    => "$fullname,,,",
        home       => $home,
        shell      => $shell,
        allowdupe  => false,
        managehome => $managehome,
        require    => Group["$username"],
    }

    group { "$username":
        ensure => $ensure,
        allowdupe  => false,
    }

    if $password != '' {
        User <| title == "$username" |> { password => $password }
    }

}
