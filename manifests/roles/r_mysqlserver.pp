#TODO: Add Anchor and Ordering

class   r_mysqlserver   {

    include mysql

    class { 'mysql::server':
        config_hash => {'root_password' => 'password'}
    }

    class { 'mysql::server::account_security': }

}
