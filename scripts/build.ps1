<#
.SYNOPSIS
    Orchestrates the local build process for the Skillable SQL Migration Lab.

.DESCRIPTION
    Runs all local build steps in order:
      1. Validates the Bicep template compiles cleanly.
      2. Packages release artifacts (if -Package is specified).

    This script is intended for local developer use only.
    CI validation is handled separately by the GitHub Actions workflow.

.PARAMETER Package
    When specified, also runs package-artifacts.ps1 after validation.

.EXAMPLE
    # Validate only
    ./scripts/build.ps1

    # Validate and package
    ./scripts/build.ps1 -Package

.NOTES
    Prerequisites: Azure CLI with the Bicep extension installed.
    Authentication to Azure is NOT required or performed by this script.
#>

#Requires -Version 7.0
[CmdletBinding()]
param(
    [switch]$Package
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot

Write-Host '[build] Running validation...'
& "$PSScriptRoot/validate.ps1"

if ($Package) {
    Write-Host '[build] Running artifact packaging...'
    & "$PSScriptRoot/package-artifacts.ps1"
}

Write-Host '[build] Build complete.'
