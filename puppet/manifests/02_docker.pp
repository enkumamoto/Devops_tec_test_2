class docker {
  exec { 'add-docker-repo':
    command => '/usr/bin/curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
                add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"',
    unless  => '/usr/bin/test -f /etc/apt/sources.list.d/docker.list',
    require => Exec['update-apt'],
  }

  exec { 'update-after-docker-repo':
    command => '/usr/bin/apt-get update',
    require => Exec['add-docker-repo'],
  }

  package { 'docker-ce':
    ensure  => installed,
    require => Exec['update-after-docker-repo'],
  }

  package { 'docker-compose':
    ensure  => installed,
    require => Package['docker-ce'],
  }

  service { 'docker':
    ensure    => running,
    enable    => true,
    require   => Package['docker-ce'],
  }

  exec { 'add-users-to-docker-group':
    command => '/usr/sbin/usermod -aG docker admin1 &&
                /usr/sbin/usermod -aG docker admin2',
    unless  => '/usr/bin/groups admin1 | grep -q docker &&
                /usr/bin/groups admin2 | grep -q docker',
    require => [Package['docker-ce'], User['admin1'], User['admin2']],
  }

  file { '/opt/docker':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/opt/docker/scripts':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/opt/docker/scripts/cleanup.sh':
    ensure  => file,
    content => "#!/bin/bash\n# Limpar containers, imagens e volumes não usados\ndocker system prune -f\n",
    mode    => '0755',
  }

  cron { 'docker-cleanup':
    command => '/opt/docker/scripts/cleanup.sh',
    user    => 'root',
    hour    => 2,
    minute  => 0,
    require => File['/opt/docker/scripts/cleanup.sh'],
  }
}
