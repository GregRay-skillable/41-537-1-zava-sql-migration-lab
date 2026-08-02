<#
.SYNOPSIS
    Placeholder VM-configuration script for the Skillable SQL Migration Lab.

.DESCRIPTION
    This script will be executed inside the lab virtual machine after provisioning.
    At this stage it is intentionally empty — no software is installed and no
    machine state is modified.

    Future responsibilities of this script may include:
      - Configuring SQL Server settings (e.g., enabling SQL Agent, setting memory limits)
      - Restoring the lab database from a backup retrieved from the GitHub Release asset URL
      - Applying firewall rules or network configuration inside the VM
      - Staging lab files in the expected directory structure

.NOTES
    Security policy:
      - Do NOT embed credentials, connection strings, or access tokens.
      - Do NOT hard-code subscription IDs, tenant IDs, or resource-group names.
      - Retrieve all sensitive values from environment variables injected by Skillable.

    Error handling:
      - $ErrorActionPreference = 'Stop' is set so that any unexpected error
        terminates the script immediately with a non-zero exit code, which
        Skillable treats as a provisioning failure.
#>

#Requires -Version 7.0
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

Write-Host '[sql-vm-config] Script loaded. No configuration actions defined yet.'

# TODO: Add VM-configuration steps here once the lab architecture is finalised.
