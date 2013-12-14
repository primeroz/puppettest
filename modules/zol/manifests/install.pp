class zol::install inherits zol {

    case $::osfamily {
        'Redhat': {
            $packages = ['zfs']

            # Enable EPEL repo my mirrors
            yumrepo {
                "zfs":
                    descr          =>   "ZFS of Linux for EL 6",
                    baseurl        =>   "http://archive.zfsonlinux.org/epel/${::operatingsystemmajrelease}/\$basearch/",
                    priority       =>   "10",
                    gpgcheck       =>   "0",
                    enabled        =>   "1";
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
