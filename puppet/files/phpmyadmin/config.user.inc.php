<?php
/* phpMyAdmin configuration */

// Servidor MySQL
$cfg['Servers'][$i]['host'] = getenv('PMA_HOST') ?: 'localhost';
$cfg['Servers'][$i]['port'] = getenv('PMA_PORT') ?: '3306';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['AllowNoPassword'] = false;

// Configurações de upload
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
$cfg['TempDir'] = '/tmp';

// Interface
$cfg['MaxDbList'] = 100;
$cfg['MaxTableList'] = 250;
$cfg['ShowPhpInfo'] = false;
$cfg['ShowChgPassword'] = false;
$cfg['ShowCreateDb'] = false;
$cfg['ShowDbStructureCharset'] = false;
$cfg['ShowDbStructureComment'] = false;

// Performance
$cfg['QueryHistoryDB'] = true;
$cfg['QueryHistoryMax'] = 100;

// Segurança
$cfg['ForceSSL'] = false;
$cfg['AllowUserDropDatabase'] = false;
$cfg['Confirm'] = true;

// Tema
$cfg['ThemeManager'] = true;
$cfg['ThemeDefault'] = 'pmahomme';

// Configurações específicas
$cfg['SendErrorReports'] = 'never';
$cfg['DefaultConnectionCollation'] = 'utf8mb4_unicode_ci';
$cfg['DefaultCharset'] = 'utf8mb4';

// Fim da configuração
?>