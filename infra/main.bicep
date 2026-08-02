// ---------------------------------------------------------------------------
// main.bicep — Entry-point Bicep template for the Skillable SQL Migration Lab
//
// Scope: resourceGroup
//   All resources are deployed into the Skillable-managed resource group that
//   is injected by the platform at lab start time.
//
// Security policy:
//   - Do NOT hard-code subscription IDs, tenant IDs, or resource-group names.
//   - Do NOT hard-code credentials, connection strings, or access tokens.
//   - Do NOT commit the compiled ARM JSON (*.json) — it is excluded by .gitignore.
// ---------------------------------------------------------------------------

targetScope = 'resourceGroup'

// ---------------------------------------------------------------------------
// Parameters
// ---------------------------------------------------------------------------

@description('Azure region for all resources. Defaults to the location of the target resource group.')
param location string = resourceGroup().location

// ---------------------------------------------------------------------------
// Future modules — add module references here as the lab architecture grows
// ---------------------------------------------------------------------------

// TODO: module 'modules/networking.bicep'  — virtual network, subnets, NSGs
// TODO: module 'modules/sql-vm.bicep'      — SQL Server source VM (migration source)
// TODO: module 'modules/sql-mi.bicep'      — Azure SQL Managed Instance (migration target)
// TODO: module 'modules/storage.bicep'     — Storage account for database backups
