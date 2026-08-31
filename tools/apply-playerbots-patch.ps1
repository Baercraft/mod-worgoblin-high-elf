$ErrorActionPreference = "Stop"
$Patch = Join-Path (Split-Path $PSScriptRoot -Parent) "integration/mod-worgoblin-highelf-playerbots.patch"
git apply --check $Patch
if ($LASTEXITCODE -ne 0) { throw "Playerbots patch check failed." }
git apply $Patch
if ($LASTEXITCODE -ne 0) { throw "Playerbots patch apply failed." }
Write-Host "Playerbots custom-race patch applied."
