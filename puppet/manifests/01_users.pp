class users {
  $admins = ['admin1', 'admin2']
  $auditor = 'auditor'

  group { 'admins':
    ensure => present,
    gid    => 1001,
  }

  group { 'auditors':
    ensure => present,
    gid    => 1002,
  }

  $admins.each |$user| {
    user { $user:
      ensure     => present,
      uid        => 1000 + inline_template("<%= @admins.index('${user}') + 1 %>"),
      gid        => 'admins',
      groups     => ['sudo', 'admins', 'docker'],
      shell      => '/bin/bash',
      home       => "/home/${user}",
      managehome => true,
      password   => '$6$rounds=656000$WX6lNçjC6B9e5P$',
    }

    file { "/home/${user}/.ssh":
      ensure => directory,
      owner  => $user,
      group  => $user,
      mode   => '0700',
    }

    file { "/home/${user}/.ssh/authorized_keys":
      ensure => file,
      source => "/tmp/repo/puppet/files/ssh/authorized_keys_${user}",
      owner  => $user,
      group  => $user,
      mode   => '0600',
    }

    file { "/home/${user}/.bashrc":
      ensure  => file,
      content => "export PS1='\\u@bastion:\\w\\$ '\nexport EDITOR=nano\n",
      owner   => $user,
      group   => $user,
    }
  }

  user { $auditor:
    ensure     => present,
    uid        => 2000,
    gid        => 'auditors',
    groups     => ['auditors'],
    shell      => '/bin/bash',
    home       => "/home/${auditor}",
    managehome => true,
    password   => '$6$rounds=656000$EXAMPLE$ANOTHERHASH',
  }

  file { '/etc/sudoers.d/10-admins':
    ensure  => file,
    content => "%admins ALL=(ALL) NOPASSWD: ALL\n",
    mode    => '0440',
  }

  file { '/etc/sudoers.d/20-auditor':
    ensure  => file,
    content => "auditor ALL=(ALL) NOPASSWD: /usr/bin/ls, /usr/bin/cat, /usr/bin/tail\n",
    mode    => '0440',
  }

  file_line { 'password-min-days':
    path    => '/etc/login.defs',
    line    => 'PASS_MIN_DAYS   1',
    match   => '^PASS_MIN_DAYS',
  }

  file_line { 'password-max-days':
    path    => '/etc/login.defs',
    line    => 'PASS_MAX_DAYS   90',
    match   => '^PASS_MAX_DAYS',
  }
}
