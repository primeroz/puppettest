
class r_storage {

    class { 'zol': }

    anchor { 'r_storage::begin': }
    anchor { 'r_storage::end': }

    Anchor['r_storage::begin'] -> Class['zol']
        -> Anchor['r_storage::end']

}

