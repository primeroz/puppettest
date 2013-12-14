class base::ntp (
    $config_template    =   $base::ntpparams::config_template,
    $pool_servers       =   $base::ntpparams::pool_servers,
    $service_enabled    =   $base::ntpparams::service_enabled,
    $service_ensure     =   $base::ntpparams::service_ensure,
    $service_manage     =   $base::ntpparams::service_manage,
    $panic              =   $base::ntpparams::panic,
    $config_file        =   $base::ntpparams::config_file,
    $drift_file         =   $base::ntpparams::drift_file,
    $keys_file          =   $base::ntpparams::keys_file,
    $package_name       =   $base::ntpparams::package_name,
    $service_name       =   $base::ntpparams::service_name,
    $ntp_servers        =   $base::ntpparams::ntp_servers,

) inherits base::ntpparams {
    validate_absolute_path($config_file)
    validate_string($config_template)
    validate_absolute_path($drift_file)
    validate_array($pool_servers)
    validate_array($ntp_servers)
    validate_bool($service_enabled)
    validate_bool($service_manage)
    validate_string($service_ensure)
    validate_bool($panic)
    validate_array($package_name)
    validate_string($service_name)


    package { 'ntp':
        ensure =>   'installed',
        name   =>   $package_name,
        before =>   File["${config_file}"],
    }

    file { "${config_file}":
        ensure  =>  file,
        owner   =>  0,
        group   =>  0,
        mode    =>  "0644",
        content =>  template($config_template),
        require =>  Package['ntp'],
        notify =>   Service['ntp'],
    }

    if ! ($service_ensure in ['running','stopped']) {
        fail('$service_ensure must be either running or stopped')
    }

    if $service_manage == true {
        service { 'ntp':
            ensure     =>   $service_ensure,
            enable     =>   $service_enable,
            name       =>   $service_name,
            hasstatus  =>   true,
            hasrestart =>   true,
            require    =>   File["${config_file}"],
        }
    }
}
