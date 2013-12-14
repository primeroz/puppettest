
class base::motd (
    $ensure = 'absent',
    $config_file = '',
    $template = '',
) {

  file { $config_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
  }    

}
