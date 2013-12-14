
class freepbx::install {

    #Will fail exec if default. 
    #TODO default to something better!
    $path_real = hiera("path_real","")
    #Set asterisk user attributes
    User <| title == "asterisk" |> { 
        shell => "/sbin/nologin",
        home  => "/var/lib/asterisk",
    }

    database  { ["asterisk","asteriskcdrdb"]:
              ensure  => present,
              #charset => "utf-8",
              before  => Utils::Netinstall["freepbx_install"],
              }

    database_user {"asterisk@localhost":
                    ensure        => present,
                    password_hash => $freepbx::params::asterisk_dbpassword,
                  }

    database_user {"asteriskcdrdb@localhost":
                    ensure        => present,
                    password_hash => $freepbx::params::asterisk_dbpassword,
                  }

    database_grant  { "asterisk@localhost/asterisk.*":
                        privileges => ['ALL'],
                    }

    database_grant  { "asteriskcdrdb@localhost/asteriskcdrdb.*":
                        privileges => ['ALL'],
                    }

    # Enable Asterisk Repo
    case $::osfamily {
        'Redhat': {
            yumrepo {
                "asterisk":
                    descr          =>   "Asterisk Repository for Redhat",
                    baseurl        =>   $freepbx::params::asterisk_repo_url,
                    gpgcheck       =>   "0",
                    enabled        =>   "1",
            }
            yumrepo {
                "digium":
                    descr          =>   "Digium Repository for Redhat",
                    baseurl        =>   $freepbx::params::digium_repo_url,
                    gpgcheck       =>   "0",
                    enabled        =>   "1",
            }
        }
    }

    package { $freepbx::params::asterisk_packages:
        ensure  => "installed",
        require => [Yumrepo['asterisk'],Yumrepo['digium']]
    }

    package { $freepbx::params::freepbx_packages:
        ensure  => "installed",
        require => [Yumrepo['asterisk'],Yumrepo['digium']],
        before  => Utils::Netinstall['freepbx_install'],
    }

    utils::netinstall { "freepbx_install":
            url                 => "$freepbx::params::freepbx_url",
            destination_dir     => "$freepbx::params::freepbx_destinationdir",
            require             => [File["/data"],Package["asterisk"]],
          }

    exec{ "freepbx_dbinstall":
      command     => "mysql --defaults-file=/root/.my.cnf -u root asterisk < SQL/newinstall.sql",
      cwd         => "$freepbx::params::freepbx_destinationdir/freepbx-$freepbx::params::freepbx_version",
      path        => $path_real,
      user        => "root",
      refreshonly => true,
      subscribe   => Database["asterisk"],
      require     => Utils::Netinstall["freepbx_install"],
    }

    #Comment install amp, need augeas first
    #exec{ "freepbx_install_amp":
    #  command     => "./start_asterisk start && ./install_amp",
    #  creates     => "${freepbx::params::amportal_AMPWEBROOT}/index.php",
    #  cwd         => "$freepbx::params::freepbx_destinationdir/freepbx-$freepbx::params::freepbx_version",
    #  path        => $path_real,
    #  user        => "root",
    #  require     => [Utils::Netinstall["freepbx_install"],Exec['freepbx_dbinstall']],
    #}


}
