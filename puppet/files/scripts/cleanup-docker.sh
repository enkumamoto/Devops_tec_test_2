#!/bin/bash
echo "=== LIMPEZA DOCKER - $(date) ==="

# Limpar containers parados
echo "Removendo containers parados..."
docker container prune -f

# Limpar imagens não utilizadas
echo "Removendo imagens não utilizadas..."
docker image prune -af

# Limpar volumes não utilizados
echo "Removendo volumes não utilizados..."
docker volume prune -f

# Limpar networks não utilizadas
echo "Removendo networks não utilizadas..."
docker network prune -f

# Limpar cache do builder
echo "Limpando cache do builder..."
docker builder prune -af

echo "=== LIMPEZA CONCLUÍDA ==="
echo "Espaço liberado:"
docker system df