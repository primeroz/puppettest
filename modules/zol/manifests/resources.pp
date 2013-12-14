class zol::resources (
  $zpool = '',
  $zfs = '',
  $pools_defaults = {},
  $zfs_defaults = {},
  ){


  if ($zol::resources::zpool != '') and ($zol::resources::zfs != '') {

    #Create resources from hash
    create_resources(zol::zpool,$zol::resources::zpool,$pools_defaults)
    create_resources(zol::zfs,$zol::resources::zfs,$zfs_defaults)

  }
}
