#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "🐳 Установка MAX в Docker..."

# Проверяем наличие DEB файла
if [ ! -f "$PROJECT_DIR/MAX.deb" ]; then
    echo "❌ Ошибка: Файл MAX.deb не найден в папке проекта!"
    echo "📥 Пожалуйста, скачайте MAX.deb и положите в папку: $PROJECT_DIR"
	echo "Пытаюсь скачать MAX"
	wget -O "$PROJECT_DIR/MAX.deb" "https://download.max.ru/electron/MAX.deb" 2> /dev/null > /dev/null;
	if [ $? -ne 0 ]; then
		echo "❌ Не удалось скачать MAX.deb!, пожалуйста, попробуйте самостоятельно!"
		exit 1
	fi
fi

# Проверяем Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен!"
    exit 1
fi

# Проверяем Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose не установлен!"
    exit 1
fi

# Проверяем X11
if [ -z "$DISPLAY" ]; then
    echo "❌ DISPLAY не установлен! Убедитесь что запускаете в X11 сессии."
    exit 1
fi

# Собираем образ
echo "🔨 Сборка Docker образа..."
cd "$PROJECT_DIR"
docker-compose build

# Создаем папку для данных
mkdir -p "$PROJECT_DIR/data"

# Даем права на папку данных
chmod 755 "$PROJECT_DIR/data"

# Создаем desktop файл
echo "📝 Создание ярлыка на рабочем столе..."
"$SCRIPT_DIR/create-desktop.sh"

# Даем права на выполнение скриптов
chmod +x "$SCRIPT_DIR"/*.sh

echo "✅ Установка завершена!"
echo "🚀 Для запуска выполните: ./scripts/run.sh"
echo "🛑 Для остановки: ./scripts/stop.sh"
