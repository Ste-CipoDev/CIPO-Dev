# Script di aggiornamento automatico per C.I.P.O. (cipo-dev)
$ErrorActionPreference = "Stop"

Write-Host "Verifica e aggiornamento di C.I.P.O. (cipo-dev) in corso..." -ForegroundColor Cyan

$destSkills = "$env:USERPROFILE\.gemini\config\skills\cipo-dev"
$legacySkill = "$env:USERPROFILE\.gemini\config\skills\cipo"
$legacyPlugin = "$env:USERPROFILE\.gemini\config\plugins\cipo"

# Assicurati che la cartella della skill esista
New-Item -ItemType Directory -Force -Path $destSkills | Out-Null

# Pulizia di sicurezza di eventuali versioni legacy o duplicate
if (Test-Path $legacySkill) {
    Remove-Item -Recurse -Force $legacySkill -ErrorAction SilentlyContinue
}
if (Test-Path $legacyPlugin) {
    Remove-Item -Recurse -Force $legacyPlugin -ErrorAction SilentlyContinue
}

$baseUrl = "https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Dev/main"

try {
    # Se eseguito dentro la cartella locale clonata del repository
    if (Test-Path ".\skills\cipo-dev\SKILL.md") {
        Write-Host "Aggiornamento dai file locali del repository..." -ForegroundColor Yellow
        Copy-Item -Force ".\skills\cipo-dev\SKILL.md" -Destination "$destSkills\SKILL.md"
    } else {
        # Altrimenti scarica l'ultima versione direttamente da GitHub
        Write-Host "Download dell'ultima versione da GitHub (Ste-CipoDev/CIPO-Dev)..." -ForegroundColor Yellow
        Invoke-RestMethod -Uri "$baseUrl/skills/cipo-dev/SKILL.md" -OutFile "$destSkills\SKILL.md"
    }

    Write-Host "C.I.P.O. (cipo-dev) aggiornato con successo all'ultima versione!" -ForegroundColor Green
} catch {
    Write-Host "Errore durante l'aggiornamento: $_" -ForegroundColor Red
}
