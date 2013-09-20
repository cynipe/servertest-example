node /db/ {

  class { 'postgresql::server':
    config_hash => {
      'ip_mask_deny_postgres_user' => '0.0.0.0/32',
      'ip_mask_allow_all_users'    => '0.0.0.0/0',
      'listen_addresses'           => '*',
      'postgres_password'          => 'TPSrep0rt!',
      'manage_redhat_firewall'     => true,
    },
  }
  postgresql::db { 'test1':
    user     => 'test1',
    password => 'test1',
    grant    => 'all'
  }

}
