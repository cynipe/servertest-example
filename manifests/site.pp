Exec {
  logoutput => on_failure,
  path      => [
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin',
  ]
}

Postgresql {
  locale              => 'ja_JP.utf8',
  charset             => 'utf8',
  manage_package_repo => true,
}

node default {

}

import 'nodes/*.pp'

