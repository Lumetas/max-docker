#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🛑 Остановка MAX Messenger..."

cd "$PROJECT_DIR"
docker-compose down

# Убираем доступ к X11
xhost -local:docker > /dev/null 2>&1

echo "✅ Остановлено!"
