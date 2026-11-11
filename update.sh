#!/usr/bin/env bash
# Script di aggiornamento automatico per C.I.P.O. (cipo-dev) per Linux/macOS
set -euo pipefail

echo -e "\033[0;36mVerifica e aggiornamento di C.I.P.O. (cipo-dev) in corso...\033[0m"

DEST_GEMINI="$HOME/.gemini/config/skills/cipo-dev"
BASE_URL="https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Dev/main"

mkdir -p "$DEST_GEMINI"

# Rimozione legacy
rm -rf "$HOME/.gemini/config/skills/cipo" "$HOME/.gemini/config/plugins/cipo" 2>/dev/null || true

if [ -f "./skills/cipo-dev/SKILL.md" ]; then
    echo -e "\033[0;33mAggiornamento dai file locali del repository...\033[0m"
    cp -f "./skills/cipo-dev/SKILL.md" "$DEST_GEMINI/SKILL.md"
else
    echo -e "\033[0;33mDownload dell'ultima versione da GitHub (Ste-CipoDev/CIPO-Dev)...\033[0m"
    curl -fsSL "$BASE_URL/skills/cipo-dev/SKILL.md" -o "$DEST_GEMINI/SKILL.md"
fi

# Sincronizzazione su altri ambienti rilevati
if [ -d "$HOME/.claude/skills/cipo-dev" ]; then
    cp -f "$DEST_GEMINI/SKILL.md" "$HOME/.claude/skills/cipo-dev/SKILL.md"
fi

if [ -d "$HOME/.agents/skills/cipo-dev" ]; then
    cp -f "$DEST_GEMINI/SKILL.md" "$HOME/.agents/skills/cipo-dev/SKILL.md"
fi

echo -e "\033[0;32mC.I.P.O. (cipo-dev) aggiornato con successo all'ultima versione!\033[0m"
