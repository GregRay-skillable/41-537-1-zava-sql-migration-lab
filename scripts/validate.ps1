<#
.SYNOPSIS
    Runs local pre-commit validation checks for the Skillable SQL Migration Lab.

.DESCRIPTION
    Validates that:
      1. The Azure CLI and Bicep extension are available.
      2. infra/main.bicep compiles without errors (az bicep build).

    This script mirrors the checks performed by the CI workflow so that
    developers can catch issues before pushing.

.NOTES
    Authentication to Azure is NOT required or performed.
    No resources are deployed.

.EXAMPLE
    ./scripts/validate.ps1
#>

#Requires -Version 7.0
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot  = Split-Path -Parent $PSScriptRoot
$BicepFile = Join-Path $RepoRoot 'infra' 'main.bicep'

# ---------------------------------------------------------------------------
# Check prerequisites
# ---------------------------------------------------------------------------

Write-Host '[validate] Checking for Azure CLI...'
if (-not (Get-Command 'az' -ErrorAction SilentlyContinue)) {
    throw 'Azure CLI (az) is not installed or not on PATH. Install it from https://aka.ms/installazurecliwindows'
}

Write-Host '[validate] Ensuring Bicep extension is installed...'
az bicep install 2>&1 | Write-Host

# ---------------------------------------------------------------------------
# Compile Bicep
# ---------------------------------------------------------------------------

Write-Host "[validate] Compiling '$BicepFile'..."
az bicep build --file $BicepFile

Write-Host '[validate] Bicep validation passed.'

# Clean up the generated ARM JSON so it is never accidentally committed
$ArmJson = [System.IO.Path]::ChangeExtension($BicepFile, '.json')
if (Test-Path $ArmJson) {
    Remove-Item $ArmJson -Force
    Write-Host '[validate] Removed generated ARM JSON (not for source control).'
}
