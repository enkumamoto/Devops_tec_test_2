#!/bin/bash
# Backup simples do banco de dados MySQL

DB_HOST="localhost"
DB_USER="admin"
DB_PASS="password"
BACKUP_DIR="/opt/backups/mysql"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Backup de todos os bancos
mysqldump --all-databases \
  --single-transaction \
  --routines \
  --triggers \
  -h $DB_HOST \
  -u $DB_USER \
  -p$DB_PASS > $BACKUP_DIR/full-backup-$DATE.sql

# Compactar
gzip $BACKUP_DIR/full-backup-$DATE.sql

# Manter apenas últimos 7 backups
find $BACKUP_DIR -name "*.gz" -mtime +7 -delete

echo "Backup concluído: $BACKUP_DIR/full-backup-$DATE.sql.gz"