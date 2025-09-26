#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

DESKTOP_FILE="$HOME/.local/share/applications/max-docker.desktop"

cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=MAX Messenger (Docker)
Comment=MAX Messenger в изолированном Docker контейнере
Exec=$PROJECT_DIR/scripts/run.sh
Icon=dialog-information
Terminal=false
StartupNotify=true
Categories=Network;InstantMessaging;
EOF

chmod +x "$DESKTOP_FILE"
chmod +x "$PROJECT_DIR/scripts/run.sh"
chmod +x "$PROJECT_DIR/scripts/install.sh"

echo "✅ Ярлык создан: $DESKTOP_FILE"
