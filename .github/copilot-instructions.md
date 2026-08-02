# GitHub Copilot Instructions — Skillable SQL Migration Lab

These instructions apply to all AI-assisted work in this repository.

---

## Infrastructure source of truth

- **Bicep is the infrastructure source of truth.** All Azure resources must be defined in `.bicep` files under `infra/`.
- Do not write or suggest ARM JSON, Terraform, or any other IaC format unless explicitly instructed.
- Generated ARM JSON (`*.json`) must **never** be committed; it is excluded by `.gitignore`.

---

## Scope

- All Bicep files must use **`targetScope = 'resourceGroup'`** or inherit it from `main.bicep`.
- Do not use subscription-scope (`targetScope = 'subscription'`) or management-group scope.
- Do not reference cross-resource-group resources unless there is a documented architectural reason.

---

## No hard-coded environment values

Never hard-code the following in any file in this repository:

| Category | Examples |
|---|---|
| Credentials | Passwords, connection strings, SAS tokens, API keys |
| Azure identity | Subscription IDs, tenant IDs, service-principal app IDs or secrets |
| Environment-specific names | Resource-group names, lab instance identifiers |
| Regions | Specific Azure region strings used as defaults |

Use **`resourceGroup().location`** for the `location` parameter default unless a specific resource type requires a different region (e.g., a global resource).

---

## Module design

- Keep Bicep modules **small and clearly named** — one module per logical concern (networking, compute, storage, etc.).
- Module filenames should be lowercase, hyphen-separated, and descriptive (e.g., `sql-vm.bicep`, `networking.bicep`).
- Each module must accept a `location` parameter defaulting to `resourceGroup().location`.
- Expose only the outputs that `main.bicep` actually needs.

---

## Scripts

- VM-configuration scripts live in `vm-config/`.
- Build and packaging helper scripts live in `scripts/`.
- All scripts must use `$ErrorActionPreference = 'Stop'` and `Set-StrictMode -Version Latest`.
- When proposing **substantial** changes to a script, replace the entire file rather than producing a diff or a partial snippet.
- Scripts must not authenticate to Azure or embed credentials.

---

## Commit hygiene

- Do not commit `*.bak`, `*.zip`, `out/`, or any generated `*.json` file.
- Do not commit `.azure/` directories, `azureProfile.json`, or any Azure CLI session files.
- Do not commit `.env` or any file containing secrets or local configuration.
