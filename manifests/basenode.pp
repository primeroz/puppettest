node    basenode    {
    $my_syslog_server   =   "1.2.3.4"
    $my_ntp_server      =   "1.2.3.4"
    include baseclass
}

node    devel inherits  basenode    {
    $my_syslog_server   =   "1.2.3.5"
    $my_ntp_server      =   "1.2.3.5"
    $my_zone            =   "devel"
}

node    test inherits  basenode    {
    $my_syslog_server   =   "1.2.3.5"
    $my_ntp_server      =   "1.2.3.5"
    $my_zone            =   "test"
}

node    prod inherits  basenode    {
    $my_syslog_server   =   "1.2.3.6"
    $my_ntp_server      =   "1.2.3.6"
    $my_zone            =   "prod"
}

node    default inherits    basenode    {
}

