# Release Artifacts

This directory is a **local staging area only** for binary release assets.

## What goes here (locally, never committed)

| File | Description |
|---|---|
| `*.bak` | SQL Server database backup file(s) used in the lab |

These files are excluded from Git by `.gitignore` because they are large binary files that do not belong in source-control history.

## How binary assets are distributed

Binary assets are attached to a **versioned GitHub Release**, not stored in the repository tree.

### Release workflow

1. A maintainer places the `*.bak` file(s) in this directory locally.
2. `scripts/package-artifacts.ps1` is run to produce `out/sql-vm-config.zip`.
3. A new GitHub Release is created with a semver tag (e.g., `v1.0.0`).
4. Both `database.bak` and `sql-vm-config.zip` are uploaded as release assets.
5. The Skillable lab configuration is updated to reference the new versioned asset URLs:
   - `https://github.com/<org>/<repo>/releases/download/<tag>/database.bak`
   - `https://github.com/<org>/<repo>/releases/download/<tag>/sql-vm-config.zip`

Because assets are accessed via public GitHub Release URLs, the Skillable platform can download them at lab start time without any authentication tokens stored in this repository.
