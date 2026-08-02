# Bicep Modules

This directory will contain individual Bicep module files as the lab infrastructure is designed and approved.

Each module should:

- Be scoped to `resourceGroup` (inherited from `main.bicep`).
- Have a single, clearly named responsibility (e.g., `networking.bicep`, `sql-vm.bicep`).
- Accept only the parameters it needs; never hard-code subscription IDs, tenant IDs, resource-group names, or regions.
- Use `resourceGroup().location` for the `location` parameter default unless a specific resource requires a different region.
- Expose outputs that `main.bicep` can use to wire modules together.

## Planned Modules

| File | Purpose |
|---|---|
| `networking.bicep` | Virtual network, subnets, and Network Security Groups |
| `sql-vm.bicep` | SQL Server 2019 source VM (migration source) |
| `sql-mi.bicep` | Azure SQL Managed Instance (migration target) |
| `storage.bicep` | Storage account for database backup blobs |

> **Note:** None of the above modules exist yet. Add them incrementally once the architecture is finalised and approved.
