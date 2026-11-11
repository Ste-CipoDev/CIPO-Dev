# Script di aggiornamento automatico per C.I.P.O. (cipo-dev)
$ErrorActionPreference = "Stop"

Write-Host "Verifica e aggiornamento di C.I.P.O. (cipo-dev) in corso..." -ForegroundColor Cyan

$destSkills = "$env:USERPROFILE\.gemini\config\skills\cipo-dev"
$legacySkill = "$env:USERPROFILE\.gemini\config\skills\cipo"
$legacyPlugin = "$env:USERPROFILE\.gemini\config\plugins\cipo"

New-Item -ItemType Directory -Force -Path $destSkills | Out-Null

if (Test-Path $legacySkill) {
    Remove-Item -Recurse -Force $legacySkill -ErrorAction SilentlyContinue
}
if (Test-Path $legacyPlugin) {
    Remove-Item -Recurse -Force $legacyPlugin -ErrorAction SilentlyContinue
}

$baseUrl = "https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Dev/main"

try {
    if (Test-Path ".\skills\cipo-dev\SKILL.md") {
        Write-Host "Aggiornamento dai file locali del repository..." -ForegroundColor Yellow
        Copy-Item -Force ".\skills\cipo-dev\SKILL.md" -Destination "$destSkills\SKILL.md"
    } else {
        Write-Host "Download dell'ultima versione da GitHub (Ste-CipoDev/CIPO-Dev)..." -ForegroundColor Yellow
        Invoke-RestMethod -Uri "$baseUrl/skills/cipo-dev/SKILL.md" -OutFile "$destSkills\SKILL.md"
    }

    $claudeSkills = "$env:USERPROFILE\.claude\skills\cipo-dev"
    if (Test-Path (Split-Path $claudeSkills)) {
        New-Item -ItemType Directory -Force -Path $claudeSkills | Out-Null
        Copy-Item -Force "$destSkills\SKILL.md" -Destination "$claudeSkills\SKILL.md"
        Write-Host "Skill aggiornata in: $claudeSkills\" -ForegroundColor Green
    }

    $agentsSkills = "$env:USERPROFILE\.agents\skills\cipo-dev"
    if (Test-Path (Split-Path $agentsSkills)) {
        New-Item -ItemType Directory -Force -Path $agentsSkills | Out-Null
        Copy-Item -Force "$destSkills\SKILL.md" -Destination "$agentsSkills\SKILL.md"
        Write-Host "Skill aggiornata in: $agentsSkills\" -ForegroundColor Green
    }

    Write-Host "C.I.P.O. (cipo-dev) aggiornato con successo all'ultima versione!" -ForegroundColor Green
} catch {
    Write-Host "Errore durante l'aggiornamento: $_" -ForegroundColor Red
}
