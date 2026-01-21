class phpmyadmin {
  file { '/opt/docker/phpmyadmin':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { '/opt/docker/phpmyadmin/.env':
    ensure  => file,
    content => template('phpmyadmin/env.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }
  file { '/opt/docker/phpmyadmin/config.user.inc.php':
    ensure  => file,
    source  => 'puppet:///files/phpmyadmin/config.user.inc.php',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  file { '/opt/docker/phpmyadmin/docker-compose.yml':
    ensure  => file,
    source  => 'puppet:///files/phpmyadmin/docker-compose.yml',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
  file { '/opt/docker/scripts/phpmyadmin-control.sh':
    ensure  => file,
    content => "#!/bin/bash\n\ncd /opt/docker/phpmyadmin\n\ncase \"\$1\" in\n  start)\n    docker-compose up -d\n    ;;\n  stop)\n    docker-compose down\n    ;;\n  restart)\n    docker-compose restart\n    ;;\n  status)\n    docker-compose ps\n    ;;\n  *)\n    echo \"Uso: \$0 {start|stop|restart|status}\"\n    exit 1\n    ;;\nesac\n",
    mode    => '0755',
  }
  exec { 'start-phpmyadmin':
    command => '/opt/docker/scripts/phpmyadmin-control.sh start',
    unless  => '/usr/bin/docker ps --format \"{{.Names}}\" | grep -q phpmyadmin',
    require => [
      File['/opt/docker/phpmyadmin/.env'],
      File['/opt/docker/phpmyadmin/docker-compose.yml'],
      File['/opt/docker/scripts/phpmyadmin-control.sh'],
      Service['docker'],
    ],
  }
  file { '/opt/docker/scripts/check-phpmyadmin.sh':
    ensure  => file,
    content => "#!/bin/bash\n\n# Verificar se phpMyAdmin está respondendo\nif curl -f http://localhost:8080/ > /dev/null 2>&1; then\n  echo \"OK: phpMyAdmin está funcionando\"\n  exit 0\nelse\n  echo \"ERRO: phpMyAdmin não está respondendo\"\n  # Tentar reiniciar\n  cd /opt/docker/phpmyadmin\n  docker-compose restart\n  exit 1\nfi\n",
    mode    => '0755',
  }
  cron { 'phpmyadmin-health-check':
    command => '/opt/docker/scripts/check-phpmyadmin.sh >> /var/log/phpmyadmin-health.log 2>&1',
    user    => 'root',
    minute  => '*/5',
    require => File['/opt/docker/scripts/check-phpmyadmin.sh'],
  }
}
