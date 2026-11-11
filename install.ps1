# Script di installazione automatica di C.I.P.O. (cipo-dev) per Google Antigravity
$ErrorActionPreference = "Stop"

Write-Host "Installazione di C.I.P.O. (cipo-dev) in corso..." -ForegroundColor Cyan

$destSkills = "$env:USERPROFILE\.gemini\config\skills\cipo-dev"

# Creazione cartella di destinazione per la skill globale
New-Item -ItemType Directory -Force -Path $destSkills | Out-Null

$baseUrl = "https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Dev/main"

# Download definizione skill globale
Invoke-RestMethod -Uri "$baseUrl/skills/cipo-dev/SKILL.md" -OutFile "$destSkills\SKILL.md"

# Rimozione di eventuali versioni legacy duplicate registrate con vecchio nome o come plugin
$legacySkill = "$env:USERPROFILE\.gemini\config\skills\cipo"
if (Test-Path $legacySkill) {
    Remove-Item -Recurse -Force $legacySkill -ErrorAction SilentlyContinue
}
$legacyPlugin = "$env:USERPROFILE\.gemini\config\plugins\cipo"
if (Test-Path $legacyPlugin) {
    Remove-Item -Recurse -Force $legacyPlugin -ErrorAction SilentlyContinue
}

Write-Host "C.I.P.O. (cipo-dev) installato con successo! È pronto e richiamabile come skill in qualsiasi progetto Antigravity." -ForegroundColor Green
