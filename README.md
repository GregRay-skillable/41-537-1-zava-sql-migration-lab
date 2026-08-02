# Skillable Azure SQL Migration Lab

Infrastructure-as-code and deployment artifacts for the Skillable Azure SQL Managed Instance migration lab.

---

## Source of Truth

**GitHub is the single source of truth** for all infrastructure templates and configuration scripts.

- All Bicep templates live under `infra/`.
- All VM-configuration scripts live under `vm-config/`.
- All helper build/packaging scripts live under `scripts/`.
- Binary release assets (database backups, zip archives) are published through **versioned GitHub Releases** and are **never** stored in normal Git history.

---

## How Skillable Consumes This Repository

| Asset | How Skillable Consumes It |
|---|---|
| Azure infrastructure | Skillable fetches `infra/main.bicep` by **public external URL** (raw GitHub URL of a tagged release or `main` branch). |
| `database.bak` | Downloaded at lab start-time from the **GitHub Release** asset URL for the appropriate version tag. |
| `sql-vm-config.zip` | Downloaded at lab start-time from the **GitHub Release** asset URL for the appropriate version tag. |

Skillable manages its own Azure subscription. Authentication to Azure is handled entirely by the Skillable platform — **no credentials, service principals, or Azure CLI login steps are required or permitted in this repository**.

---

## Deployment Target

All Azure resources are deployed into a **Skillable-managed resource group**. The resource-group name, subscription ID, and tenant ID are injected by Skillable at lab deployment time and must **never** be hard-coded in any file in this repository.

---

## Security Policy

The following items **must never be committed** to this repository:

- Credentials of any kind (passwords, connection strings, SAS tokens)
- Azure access tokens or subscription IDs
- Tenant IDs or application/service-principal secrets
- Any file that contains environment-specific values for a particular lab instance

See `.gitignore` for a full list of excluded file patterns.

---

## Repository Layout

```
.github/
  workflows/
    validate-bicep.yml    # CI: validates Bicep compiles cleanly on every PR/push
  copilot-instructions.md # Copilot coding guidelines for this project

infra/
  main.bicep              # Entry-point Bicep template (resourceGroup scope)
  modules/
    README.md             # Describes future Bicep module files

vm-config/
  sql-vm-config.ps1       # PowerShell script run inside the lab VM

scripts/
  build.ps1               # Orchestrates the local build process
  package-artifacts.ps1   # Packages release assets (*.bak, *.zip)
  validate.ps1            # Runs local pre-commit validation checks

artifacts/
  README.md               # Explains the binary release-asset strategy

.gitignore
README.md
```

---

## Local Development Prerequisites

| Tool | Minimum Version | Purpose |
|---|---|---|
| Azure CLI | 2.50+ | `az bicep build` validation |
| Bicep CLI | bundled with Azure CLI | Compile Bicep to ARM JSON |
| PowerShell | 7.4+ | Run helper scripts |

Install the Bicep extension for Azure CLI if it is not already present:

```bash
az bicep install
```

Validate the Bicep template locally:

```bash
az bicep build --file infra/main.bicep
```

---

## CI / Workflow

The `validate-bicep.yml` workflow runs on every pull request and push to `main`. It:

1. Installs the Azure CLI and Bicep extension.
2. Runs `az bicep build --file infra/main.bicep`.
3. Fails the PR if the template does not compile cleanly.

The workflow does **not** authenticate to Azure and does **not** deploy any resources.

---

## Release Process

Binary assets (`database.bak`, `sql-vm-config.zip`) are created and attached to a **GitHub Release** by the maintainer:

1. Run `scripts/package-artifacts.ps1` locally to produce the zip archive.
2. Create a new GitHub Release with a semver tag (e.g., `v1.0.0`).
3. Upload the binary assets to the release.
4. Update Skillable lab configuration to reference the new asset URLs.

---

## Contributing

1. Fork or branch from `main`.
2. Make infrastructure changes under `infra/` using Bicep.
3. Ensure `az bicep build --file infra/main.bicep` passes locally.
4. Open a pull request — the CI workflow will validate the template automatically.
