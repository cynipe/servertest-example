node /web/ {

  include apache
  apache::vhost { 'test.example.com':
    port    => '80',
    docroot => '/var/www/test',
  }

}
