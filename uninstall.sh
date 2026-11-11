#!/usr/bin/env bash
# Script di disinstallazione completa di C.I.P.O. (cipo-dev) per Linux/macOS
set -euo pipefail

echo -e "\033[0;33mRimozione di C.I.P.O. in corso...\033[0m"

REMOVED=0

if [ -d "$HOME/.gemini/config/skills/cipo-dev" ]; then
    rm -rf "$HOME/.gemini/config/skills/cipo-dev"
    echo -e "\033[0;36mRimossa skill: $HOME/.gemini/config/skills/cipo-dev\033[0m"
    REMOVED=1
fi

if [ -d "$HOME/.gemini/config/skills/cipo" ]; then
    rm -rf "$HOME/.gemini/config/skills/cipo"
    REMOVED=1
fi

if [ -d "$HOME/.claude/skills/cipo-dev" ]; then
    rm -rf "$HOME/.claude/skills/cipo-dev"
    echo -e "\033[0;36mRimossa skill: $HOME/.claude/skills/cipo-dev\033[0m"
    REMOVED=1
fi

if [ -d "$HOME/.agents/skills/cipo-dev" ]; then
    rm -rf "$HOME/.agents/skills/cipo-dev"
    echo -e "\033[0;36mRimossa skill: $HOME/.agents/skills/cipo-dev\033[0m"
    REMOVED=1
fi

if [ "$REMOVED" -eq 1 ]; then
    echo -e "\033[0;32mC.I.P.O. rimosso con successo dal sistema.\033[0m"
else
    echo -e "\033[0;90mNessuna installazione di C.I.P.O. trovata nel percorso dell'utente.\033[0m"
fi
