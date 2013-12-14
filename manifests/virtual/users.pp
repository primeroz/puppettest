# Users Virtual Resources

class v_users {
    @users::account { 'fc':
        fullname => "Francesco Ciocchetti",
        password => '$6$I93ZXmY6fv6EDaaG$uCAW9t5GaAKYPjOvdM2Rjhlpu49RmMgi2VMR4TcpJLLKpnl7Wn1716r5pg4HMKeoBjWhlIvATAql4hnac3Mrf.',
        groups   => ['wheel'],
        tag      => ['users_common'],
    }

    @users::account { 'asterisk':
        fullname => "Asterisk role user",
        tag      => ['freepbx'],
        home     => "/var/run/asterisk",
    }
}
