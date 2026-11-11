#!/usr/bin/env bash
# Script di installazione automatica di C.I.P.O. (cipo-dev) per Linux/macOS
set -euo pipefail

TANDEM=0
for arg in "$@"; do
    if [ "$arg" == "--tandem" ] || [ "$arg" == "-t" ]; then
        TANDEM=1
    fi
done

echo -e "\033[0;36mInstallazione di C.I.P.O. (cipo-dev) in corso...\033[0m"

DEST_GEMINI="$HOME/.gemini/config/skills/cipo-dev"
BASE_URL="https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Dev/main"

# 1. Installazione principale per Google Antigravity / Gemini CLI
mkdir -p "$DEST_GEMINI"

if [ -f "./skills/cipo-dev/SKILL.md" ]; then
    cp -f "./skills/cipo-dev/SKILL.md" "$DEST_GEMINI/SKILL.md"
else
    curl -fsSL "$BASE_URL/skills/cipo-dev/SKILL.md" -o "$DEST_GEMINI/SKILL.md"
fi

# Rimozione di eventuali versioni legacy duplicate
rm -rf "$HOME/.gemini/config/skills/cipo" "$HOME/.gemini/config/plugins/cipo" 2>/dev/null || true

# 2. Rilevamento automatico di ambienti Claude Code / Open Agents se presenti
if [ -d "$HOME/.claude/skills" ]; then
    mkdir -p "$HOME/.claude/skills/cipo-dev"
    cp -f "$DEST_GEMINI/SKILL.md" "$HOME/.claude/skills/cipo-dev/SKILL.md"
    echo -e "\033[0;32mSkill sincronizzata anche in ~/.claude/skills/cipo-dev/\033[0m"
fi

if [ -d "$HOME/.agents/skills" ]; then
    mkdir -p "$HOME/.agents/skills/cipo-dev"
    cp -f "$DEST_GEMINI/SKILL.md" "$HOME/.agents/skills/cipo-dev/SKILL.md"
    echo -e "\033[0;32mSkill sincronizzata anche in ~/.agents/skills/cipo-dev/\033[0m"
fi

echo -e "\033[0;32mC.I.P.O. (cipo-dev) installato con successo! È pronto e richiamabile nel tuo ambiente.\033[0m"

if [ "$TANDEM" -eq 1 ]; then
    echo -e "\033[0;36mInstallazione combinata Tandem: installazione di CIPO-Method in corso...\033[0m"
    curl -fsSL https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Method/main/install.sh | bash
fi
