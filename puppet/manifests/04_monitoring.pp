class monitoring {
  # Instalar ferramentas de monitoramento
  $monitoring_tools = [
    'iotop',
    'iftop',
    'nethogs',
    'sysstat',
  ]

  package { $monitoring_tools:
    ensure => installed,
  }

  # Habilitar coleta de estatísticas do sistema
  file_line { 'enable-sysstat':
    path  => '/etc/default/sysstat',
    line  => 'ENABLED="true"',
    match => '^ENABLED=',
  }

  # Configurar logrotate para logs da aplicação
  file { '/etc/logrotate.d/bastion-logs':
    ensure  => file,
    content => "/var/log/phpmyadmin-health.log {\n  rotate 7\n  daily\n  missingok\n  notifempty\n  compress\n  delaycompress\n}\n\n/var/log/user-audit.log {\n  rotate 30\n  daily\n  missingok\n  notifempty\n  compress\n  delaycompress\n}\n",
  }

  # Script para verificar espaço em disco
  file { '/opt/docker/scripts/check-disk.sh':
    ensure  => file,
    content => "#!/bin/bash\n\n# Verificar uso de disco\nDISK_USAGE=\$(df -h / | awk 'NR==2 {print \$5}' | sed 's/%//')\n\nif [ \$DISK_USAGE -gt 80 ]; then\n  echo \"ALERTA: Uso de disco em \$DISK_USAGE%\"\n  # Limpar logs antigos\n  find /var/log -name \"*.log\" -mtime +30 -delete\n  find /tmp -type f -mtime +7 -delete\nfi\n",
    mode    => '0755',
  }

  # Agendar verificação de disco diária
  cron { 'check-disk-space':
    command => '/opt/docker/scripts/check-disk.sh >> /var/log/disk-check.log 2>&1',
    user    => 'root',
    hour    => 1,
    minute  => 0,
  }

  # Configurar logging de atividades de usuários
  file { '/etc/profile.d/audit-login.sh':
    ensure  => file,
    content => "#!/bin/bash\n# Registrar logins de usuários\necho \"\$(date) - Usuário \$(whoami) logado de \$SSH_CLIENT\" >> /var/log/user-audit.log\n",
    mode    => '0755',
  }

  # Script para backup de configurações
  file { '/opt/docker/scripts/backup-config.sh':
    ensure  => file,
    content => "#!/bin/bash\n# Backup de configurações importantes\nBACKUP_DIR=\"/opt/backups/config\"\nDATE=\$(date +%Y%m%d)\n\nmkdir -p \$BACKUP_DIR\n\n# Backup de configurações\ncp -r /etc/ssh \$BACKUP_DIR/ssh-\$DATE\ncp -r /opt/docker/phpmyadmin \$BACKUP_DIR/phpmyadmin-\$DATE\ncp /etc/hosts \$BACKUP_DIR/hosts-\$DATE\n\n# Compactar\ncd \$BACKUP_DIR\ntar -czf config-backup-\$DATE.tar.gz ssh-\$DATE phpmyadmin-\$DATE hosts-\$DATE\n\n# Limpar diretórios temporários\nrm -rf \$BACKUP_DIR/ssh-\$DATE \$BACKUP_DIR/phpmyadmin-\$DATE \$BACKUP_DIR/hosts-\$DATE\n\n# Manter apenas últimos 7 backups\nfind \$BACKUP_DIR -name \"config-backup-*.tar.gz\" -mtime +7 -delete\n",
    mode    => '0755',
  }

  # Agendar backup semanal
  cron { 'weekly-config-backup':
    command => '/opt/docker/scripts/backup-config.sh',
    user    => 'root',
    weekday => 0,
    hour    => 3,
    minute  => 0,
  }
}
