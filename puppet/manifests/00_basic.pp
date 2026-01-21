class basics {
  exec { 'update-apt':
    command => '/usr/bin/apt-get update',
    unless  => '/usr/bin/test -f /var/lib/apt/periodic/update-success-stamp',
  }

  $essential_packages = [
    'curl',
    'wget',
    'git',
    'htop',
    'nano',
    'net-tools',
    'ufw',
    'fail2ban',
    'chrony',
  ]

  package { $essential_packages:
    ensure  => installed,
    require => Exec['update-apt'],
  }

  file { '/etc/timezone':
    ensure  => file,
    content => "America/Sao_Paulo\n",
    notify  => Exec['reconfigure-tzdata'],
  }

  exec { 'reconfigure-tzdata':
    command     => '/usr/sbin/dpkg-reconfigure -f noninteractive tzdata',
    refreshonly => true,
  }

  service { 'chrony':
    ensure    => running,
    enable    => true,
    require   => Package['chrony'],
  }

  file { '/etc/motd':
    ensure  => file,
    content => template('basics/motd.erb'),
  }

  file_line { 'disable-root-login':
    path    => '/etc/ssh/sshd_config',
    line    => 'PermitRootLogin no',
    match   => '^PermitRootLogin',
    notify  => Service['ssh'],
  }

  file_line { 'disable-password-auth':
    path    => '/etc/ssh/sshd_config',
    line    => 'PasswordAuthentication no',
    match   => '^PasswordAuthentication',
    notify  => Service['ssh'],
  }

  service { 'ssh':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }

  exec { 'setup-ufw':
    command => '/usr/sbin/ufw default deny incoming &&
                /usr/sbin/ufw default allow outgoing &&
                /usr/sbin/ufw allow 22/tcp &&
                /usr/sbin/ufw allow 8080/tcp &&
                /usr/sbin/ufw --force enable',
    unless  => '/usr/sbin/ufw status | grep -q "Status: active"',
    require => Package['ufw'],
  }
}
