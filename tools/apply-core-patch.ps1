$ErrorActionPreference = "Stop"
$Patch = Join-Path (Split-Path $PSScriptRoot -Parent) "integration/mod-worgoblin-highelf-azerothcore.patch"
git apply --check $Patch
if ($LASTEXITCODE -ne 0) { throw "Core patch check failed." }
git apply $Patch
if ($LASTEXITCODE -ne 0) { throw "Core patch apply failed." }
Write-Host "Core custom-race patch applied."
