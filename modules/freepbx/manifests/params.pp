class freepbx::params (
      $asterisk_dbpassword = "",
      $freepbx_version = "2.11.0",
      $freepbx_destinationdir = "/data/freepbx_install",
                      ) {

    case $::osfamily {
        'Redhat': {
            $asterisk_repo_url      = "http://packages.asterisk.org/centos/${operatingsystemmajrelease}/current/${architecture}"
            $digium_repo_url        = "http://packages.digium.com/centos/${operatingsystemmajrelease}/current/${architecture}"
            $asterisk_packages      = ['asterisk','asterisk-odbc','asterisk-sounds-core-en','asterisk-sounds-core-en-alaw','asterisk-sounds-core-en-ulaw','asterisk-sounds-core-en-gsm','asterisk-sounds-extra-en-alaw','asterisk-sounds-extra-en-ulaw','asterisk-sounds-extra-en-gsm','dahdi-linux','dahdi-tools','libpri','iksemel']
            $freepbx_packages      = ['freetype','libX11','libX11-common','libXau','libXpm','libjpeg-turbo','libpng','libtool-ltdl','libxcb','mysql-connector-odbc','php-pear-DB','php-process']
        }
    }

    $freepbx_url = "http://mirror.freepbx.org/freepbx-${freepbx::params::freepbx_version}.tar.gz"

    #AMPORTAL.conf variables
    $amportal_AMPDBHOST=hiera("amportal::AMPDBHOST","localhost")
    $amportal_AMPDBENGINE=hiera("amportal::AMPDBENGINE","mysql")
    $amportal_AMPENGINE=hiera("amportal::AMPENGINE","asterisk")
    $amportal_AMPMGRUSER=hiera("amportal::AMPMGRUSER","admin")
    $amportal_AMPMGRPASS=hiera("amportal::AMPMGRPASS","asterisk")
    $amportal_AMPBIN=hiera("amportal::AMPBIN","/var/lib/asterisk/bin")
    $amportal_AMPSBIN=hiera("amportal::AMPSBIN","/usr/local/sbin")
    $amportal_AMPWEBROOT=hiera("amportal::AMPWEBROOT","/var/www/html")
    $amportal_AMPCGIBIN=hiera("amportal::AMPCGIBIN","/var/www/cgi-bin")
    $amportal_FOPWEBROOT=hiera("amportal::FOPWEBROOT","/var/www/html/panel")
    $amportal_FOPPASSWORD=hiera("amportal::FOPPASSWORD","foppassword")
    $amportal_ARI_ADMIN_USERNAME=hiera("amportal::ARI_ADMIN_USERNAME","admin")
    $amportal_ARI_ADMIN_PASSWORD=hiera("amportal::ARI_ADMIN_PASSWORD","ari_password")
    $amportal_AUTH_TYPE=hiera("amportal::AUTH_TYPE","database")
    $amportal_AMPEXTENSIONS=hiera("amportal::AMPEXTENSIONS","extensions")
    $amportal_AMPVMUMASK=hiera("amportal::AMPVMUMASK=","007")
    $amportal_AMPASTERISKWEBUSER=hiera("amportal::AMPASTERISKWEBUSER=","asterisk")
    $amportal_AMPASTERISKWEBGROUP=hiera("amportal::AMPASTERISKWEBGROUP=","asterisk")
}
