#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

$PROJECT_DIR/scripts/stop.sh 2> /dev/null > /dev/null # Останавливаем предыдущий контейнер

# Разрешаем доступ к X11 для Docker
xhost +local:docker > /dev/null 2>&1

# Создаем socket для PulseAudio (если нужно)
if [ ! -S /tmp/pulseaudio.socket ]; then
    pactl load-module module-native-protocol-unix socket=/tmp/pulseaudio.socket > /dev/null
fi

echo "🚀 Запуск MAX Messenger..."

cd "$PROJECT_DIR"

# Запускаем контейнер
docker-compose up --force-recreate 2> /dev/null > /dev/null
