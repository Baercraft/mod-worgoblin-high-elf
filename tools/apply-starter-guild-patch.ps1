param([string]$StarterGuildPath = ".")
$ErrorActionPreference = "Stop"
$patch = Join-Path $PSScriptRoot "..\integration\mod-starter-guild-custom-races.patch"
Push-Location $StarterGuildPath
try {
    git apply --check $patch
    git apply $patch
    Write-Host "Starter Guild custom-race patch applied."
} finally {
    Pop-Location
}
