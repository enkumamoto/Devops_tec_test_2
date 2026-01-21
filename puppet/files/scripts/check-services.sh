#!/bin/bash
# Script para verificar status dos serviços

echo "=== VERIFICAÇÃO DE SERVIÇOS - $(date) ==="
echo ""

# Verificar Docker
echo "1. Docker:"
if systemctl is-active --quiet docker; then
    echo "   ✅ Docker está rodando"
    echo "   Containers ativos: $(docker ps --format 'table {{.Names}}\t{{.Status}}' | tail -n +2)"
else
    echo "   ❌ Docker NÃO está rodando"
fi
echo ""

# Verificar phpMyAdmin
echo "2. phpMyAdmin:"
if docker ps --format '{{.Names}}' | grep -q phpmyadmin; then
    echo "   ✅ phpMyAdmin container está rodando"
    
    # Verificar se responde HTTP
    if curl -s -f http://localhost:8080/ > /dev/null; then
        echo "   ✅ phpMyAdmin responde na porta 8080"
    else
        echo "   ⚠️  phpMyAdmin container roda mas não responde HTTP"
    fi
else
    echo "   ❌ phpMyAdmin container NÃO está rodando"
fi
echo ""

# Verificar SSH
echo "3. SSH:"
if systemctl is-active --quiet ssh; then
    echo "   ✅ SSH está rodando"
    echo "   Conexões ativas: $(ss -tn state established sport = :22 | wc -l)"
else
    echo "   ❌ SSH NÃO está rodando"
fi
echo ""

# Verificar espaço em disco
echo "4. Espaço em disco:"
df -h / | tail -1
echo ""

# Verificar memória
echo "5. Uso de memória:"
free -h | head -2
echo ""

# Verificar load average
echo "6. Load average:"
uptime | awk -F'load average:' '{print $2}'
echo ""

echo "=== VERIFICAÇÃO CONCLUÍDA ==="