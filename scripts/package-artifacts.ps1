<#
.SYNOPSIS
    Packages release assets for the Skillable SQL Migration Lab.

.DESCRIPTION
    Creates the zip archive (sql-vm-config.zip) that is uploaded to a GitHub
    Release as a binary asset.

    Binary assets are NEVER committed to Git history — they are attached to a
    GitHub Release and consumed by the Skillable platform via public asset URLs.

.NOTES
    Prerequisites:
      - The database backup (*.bak) must be placed in the artifacts/ directory
        before running this script. It is excluded from source control by .gitignore.

    This script does NOT authenticate to Azure or deploy any resources.

.EXAMPLE
    ./scripts/package-artifacts.ps1
#>

#Requires -Version 7.0
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot   = Split-Path -Parent $PSScriptRoot
$OutputDir  = Join-Path $RepoRoot 'out'
$VmConfigDir = Join-Path $RepoRoot 'vm-config'
$ZipTarget  = Join-Path $OutputDir 'sql-vm-config.zip'

# Ensure output directory exists (excluded from Git by .gitignore)
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# Package the vm-config directory into a zip archive
Write-Host "[package-artifacts] Creating $ZipTarget ..."
Compress-Archive -Path "$VmConfigDir/*" -DestinationPath $ZipTarget -Force

Write-Host "[package-artifacts] Done. Upload '$ZipTarget' to the GitHub Release as 'sql-vm-config.zip'."
Write-Host "[package-artifacts] Also upload any *.bak files from the artifacts/ directory to the same release."
