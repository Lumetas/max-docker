FROM ubuntu:22.04

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libxss1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libatspi2.0-0 \
    libwayland-egl1 \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-server0 \
    x11-xserver-utils \
    dbus-x11 \
    pulseaudio \
    && rm -rf /var/lib/apt/lists/*

# Создаем пользователя без привилегий root
RUN useradd -m -u 1000 max && \
    mkdir -p /home/max/.config /home/max/.cache && \
    chown -R max:max /home/max

# Копируем DEB пакет
COPY MAX.deb /tmp/MAX.deb

# Устанавливаем MAX
RUN apt update && apt install -y /tmp/MAX.deb


# Переключаемся на непривилегированного пользователя
# USER max
# WORKDIR /home/max
USER root
WORKDIR /root

# # Запускаем MAX
CMD ["MAX", "--no-sandbox"]
