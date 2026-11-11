[CmdletBinding()]
param(
    [switch]$Tandem
)

$ErrorActionPreference = "Stop"

Write-Host "Installazione di C.I.P.O. (cipo-dev) in corso..." -ForegroundColor Cyan

$destSkills = "$env:USERPROFILE\.gemini\config\skills\cipo-dev"
New-Item -ItemType Directory -Force -Path $destSkills | Out-Null

$baseUrl = "https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Dev/main"

# Installazione da file locale se eseguito da repo clonato, altrimenti da GitHub
if (Test-Path ".\skills\cipo-dev\SKILL.md") {
    Copy-Item -Force ".\skills\cipo-dev\SKILL.md" -Destination "$destSkills\SKILL.md"
} else {
    Invoke-RestMethod -Uri "$baseUrl/skills/cipo-dev/SKILL.md" -OutFile "$destSkills\SKILL.md"
}

# Rimozione di eventuali versioni legacy duplicate
$legacySkill = "$env:USERPROFILE\.gemini\config\skills\cipo"
if (Test-Path $legacySkill) {
    Remove-Item -Recurse -Force $legacySkill -ErrorAction SilentlyContinue
}
$legacyPlugin = "$env:USERPROFILE\.gemini\config\plugins\cipo"
if (Test-Path $legacyPlugin) {
    Remove-Item -Recurse -Force $legacyPlugin -ErrorAction SilentlyContinue
}

# Rilevamento automatico di Claude Code e Open Agents su Windows
$claudeSkills = "$env:USERPROFILE\.claude\skills"
if (Test-Path $claudeSkills) {
    New-Item -ItemType Directory -Force -Path "$claudeSkills\cipo-dev" | Out-Null
    Copy-Item -Force "$destSkills\SKILL.md" -Destination "$claudeSkills\cipo-dev\SKILL.md"
    Write-Host "Skill sincronizzata in: $claudeSkills\cipo-dev\" -ForegroundColor Green
}

$agentsSkills = "$env:USERPROFILE\.agents\skills"
if (Test-Path $agentsSkills) {
    New-Item -ItemType Directory -Force -Path "$agentsSkills\cipo-dev" | Out-Null
    Copy-Item -Force "$destSkills\SKILL.md" -Destination "$agentsSkills\cipo-dev\SKILL.md"
    Write-Host "Skill sincronizzata in: $agentsSkills\cipo-dev\" -ForegroundColor Green
}

Write-Host "C.I.P.O. (cipo-dev) installato con successo!" -ForegroundColor Green

if ($Tandem) {
    Write-Host "Installazione combinata Tandem: installazione di CIPO-Method in corso..." -ForegroundColor Cyan
    $methodScript = "https://raw.githubusercontent.com/Ste-CipoDev/CIPO-Method/main/install.ps1"
    Invoke-RestMethod -Uri $methodScript | Invoke-Expression
}
