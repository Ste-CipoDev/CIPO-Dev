# Script di disinstallazione completa di C.I.P.O. (cipo-dev) per Google Antigravity e ambienti agentici
$ErrorActionPreference = "Stop"

Write-Host "Rimozione di C.I.P.O. in corso..." -ForegroundColor Yellow

$destSkills = "$env:USERPROFILE\.gemini\config\skills\cipo-dev"
$legacySkills = "$env:USERPROFILE\.gemini\config\skills\cipo"
$destPlugin = "$env:USERPROFILE\.gemini\config\plugins\cipo"
$claudeSkills = "$env:USERPROFILE\.claude\skills\cipo-dev"
$agentsSkills = "$env:USERPROFILE\.agents\skills\cipo-dev"

$rimosso = $false

if (Test-Path $destSkills) {
    Remove-Item -Recurse -Force $destSkills
    Write-Host "Rimossa skill globale: $destSkills" -ForegroundColor Cyan
    $rimosso = $true
}

if (Test-Path $legacySkills) {
    Remove-Item -Recurse -Force $legacySkills
    Write-Host "Rimossa skill legacy: $legacySkills" -ForegroundColor Cyan
    $rimosso = $true
}

if (Test-Path $destPlugin) {
    Remove-Item -Recurse -Force $destPlugin
    Write-Host "Rimosso plugin globale: $destPlugin" -ForegroundColor Cyan
    $rimosso = $true
}

if (Test-Path $claudeSkills) {
    Remove-Item -Recurse -Force $claudeSkills
    Write-Host "Rimossa skill Claude Code: $claudeSkills" -ForegroundColor Cyan
    $rimosso = $true
}

if (Test-Path $agentsSkills) {
    Remove-Item -Recurse -Force $agentsSkills
    Write-Host "Rimossa skill Open Agents: $agentsSkills" -ForegroundColor Cyan
    $rimosso = $true
}

if ($rimosso) {
    Write-Host "C.I.P.O. e tutte le relative configurazioni sono stati rimossi con successo dal sistema." -ForegroundColor Green
} else {
    Write-Host "Nessuna installazione di C.I.P.O. trovata nel percorso dell'utente." -ForegroundColor Gray
}
