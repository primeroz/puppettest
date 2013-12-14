class zol::resources (
  $zpool = '',
  $zfs = '',
  $pools_defaults = {}
  $zfs_defaults = {}
  ){


  if ($zol::resources::zpool != '') and ($zol::resources::zfs != '') {
    create_resources(zol::zpool,$zolyaml[zpool],$pools_defaults)
    create_resources(zol::zfs,$zolyaml[zfs],$zfs_defaults)
  }
}
