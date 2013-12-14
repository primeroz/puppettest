class zfs::install inherits zfs {

    case $::osfamily {
        'Redhat': {
            $packages = ['zfs']

            package { 'zfs-release':
                ensure   => 'installed',
                provider => 'rpm',
                source   => 'http://archive.zfsonlinux.org/epel/zfs-release-1-2.el6.noarch.rpm',
            } ->
            package { "zfs-packages":
                ensure => 'installed',
                name   =>   $packages,
            } ->
            service { "zfs":
                ensure    => running,
                enable    => true,
                subscribe => Package['zfs-packages'],
            }
        }
    }


}
