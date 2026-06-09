# GitHub Actions Workflows – Technical Documentation

This folder contains the automated pipelines that keep the `corr_data` repository up to date whenever research data changes. The workflows handle everything from importing raw CSV data into a relational database, running SQL queries, generating statistical plots with R, to committing all outputs back into the repository — without any manual intervention.

This document explains what each workflow does, how they depend on one another, and why they are structured the way they are.

---

## Table of Contents

1. [Overview: Three datasets, two layers](#1-overview-three-datasets-two-layers)
2. [Pipeline structure](#2-pipeline-structure)
3. [Workflow reference](#3-workflow-reference)
   - [Base workflows – DB & queries](#31-base-workflows--db--queries)
   - [Base workflows – R scripts](#32-base-workflows--r-scripts)
   - [Intersection workflows – DB & queries](#33-intersection-workflows--db--queries)
   - [Intersection workflows – R scripts](#34-intersection-workflows--r-scripts)
4. [Trigger and dependency map](#4-trigger-and-dependency-map)
5. [Concurrency and push-conflict prevention](#5-concurrency-and-push-conflict-prevention)
6. [Shared technical patterns](#6-shared-technical-patterns)
7. [Manual execution](#7-manual-execution)

---

## 1. Overview: Three datasets, two layers

The repository works with three distinct correspondence datasets:

| Short name | Full name | Database | CSV source path |
|---|---|---|---|
| **Erasmus** | Erasmus of Rotterdam | `era_cdb` | `erasmus/dataset/csv/` |
| **Pirckheimer** | Willibald Pirckheimer | `wpirck_cdb` | `pirckheimer/dataset/csv/` |
| **Budé** | Guillaume Budé | `bude_cdb` | `budé/dataset/csv/` |

The automation runs at two layers:

- **Base layer** — each dataset is processed on its own: the CSV files are imported into a MySQL database, SQL queries are executed and their results saved, and R scripts generate plots and maps from those results.
- **Intersection layer** — two pairs of datasets are analysed in combination to identify shared correspondents, overlapping networks, etc.: Erasmus × Pirckheimer and Erasmus × Budé.

---

## 2. Pipeline structure

Each dataset follows the same two-step pipeline. The intersection analyses add a third step that waits for the relevant base pipelines to finish first.

```
CSV data changes
       │
       ▼
┌─────────────────────────┐
│  1. DB & Query workflow  │  — imports CSV → MySQL, runs SQL, saves results,
│                          │    creates a DB dump, commits to repo
└────────────┬────────────┘
             │  triggers
             ▼
┌─────────────────────────┐
│  2. R Script workflow    │  — reads query results, runs R scripts,
│                          │    generates plots & maps, commits to repo
└─────────────────────────┘
```

For the intersection analyses, a second trigger condition applies: the intersection pipeline only starts once **both** of its required base pipelines have completed successfully (AND-gate logic — see [section 5](#5-concurrency-and-push-conflict-prevention)).

```
Erasmus DB & Query ──┐
                     ├──► AND-gate ──► Intersection DB & Query ──► Intersection R Scripts
Pirckheimer DB & Query ─┘
```

```
Erasmus DB & Query ──┐
                     ├──► AND-gate ──► Intersection DB & Query ──► Intersection R Scripts
Budé DB & Query ─────┘
```

---

## 3. Workflow reference

### 3.1 Base workflows – DB & queries

These three workflows are structurally identical. They run whenever new CSV data is pushed to the respective dataset folder, or manually on demand.

---

#### `create_era_db_dump_and_run_queries.yml`
**Name:** Erasmus – Setup MySQL, Import Data, Create DB Dump, and Run Queries

**Trigger:** Push to `erasmus/dataset/csv/**`

**Steps:**
1. Check out the repository
2. Install Python dependencies (`pandas`, `mysql-connector-python`)
3. Validate referential integrity of the CSV data (`erasmus/check_for_missing_db_keys.py`)
4. Import the CSV data into the MySQL database `era_cdb` (`erasmus/database/create_script/import_data.py`)
5. Dump the populated database to `erasmus/database/dump/era_cdb_dump.sql`
6. Run all SQL queries and save results to `erasmus/query_results/` (`erasmus/run_queries.py`)
7. Commit and push all changes to `master`

---

#### `create_wpirck_db_dump_and_run_queries.yml`
**Name:** Pirckheimer – Setup MySQL, Import Data, Create DB Dump, and Run Queries

**Trigger:** Push to `pirckheimer/dataset/csv/**`

**Steps:** identical to the Erasmus workflow above, targeting database `wpirck_cdb` and the `pirckheimer/` folder.

---

#### `create_bude__db_dump_and_run_queries.yml`
**Name:** Budé – Setup MySQL, Import Data, Create DB Dump, and Run Queries

**Trigger:** Push to `budé/dataset/csv/**`

**Steps:** identical to the Erasmus workflow above, targeting database `bude_cdb` and the `budé/` folder.

---

### 3.2 Base workflows – R scripts

These workflows are triggered automatically when the corresponding DB & query workflow completes. They run inside a pre-built R environment (`rocker/geospatial:4.5.1`) so that no system-level dependencies need to be installed from scratch.

---

#### `erasmus_run_r_scripts.yml`
**Name:** Erasmus – Run R Scripts and Save Outputs

**Trigger:** Completion of the Erasmus DB & query workflow

**Steps:**
1. Check out the repository
2. Install required R packages: `leaflet`, `leaflet.extras`, `svglite`, `ggrepel`, `patchwork`, `lubridate`, `classInt`, `htmlwidgets`, `htmltools`, `igraph`, `rgexf`, `ndtv`
3. Temporarily rewrite `setwd()` calls in the R scripts to match the GitHub Actions directory structure
4. Run all `.R` files found under `erasmus/r_scripts/`
5. Revert the `setwd()` rewrites so the scripts remain portable locally
6. Commit and push all generated plots and maps to `master`

**Outputs:** plots saved to `erasmus/r_plots/`, interactive maps to `erasmus/leaflet_maps/`

---

#### `pirckheimer_run_r_scripts.yml`
**Name:** Pirckheimer – Run R Scripts and Save Outputs

**Trigger:** Completion of the Pirckheimer DB & query workflow

**Steps and outputs:** identical in structure to the Erasmus R workflow, targeting `pirckheimer/r_scripts/`, `pirckheimer/r_plots/`, and `pirckheimer/leaflet_maps/`.

---

#### `bude__run_r_scripts.yml`
**Name:** Budé – Run R Scripts and Save Outputs

**Trigger:** Completion of the Budé DB & query workflow

**Steps and outputs:** identical in structure to the Erasmus R workflow, targeting `budé/r_scripts/`, `budé/r_plots/`, and `budé/leaflet_maps/`.

---

### 3.3 Intersection workflows – DB & queries

These workflows combine two datasets in a single MySQL instance to run cross-dataset queries. They use an AND-gate mechanism to ensure they only execute once **both** of their prerequisite base workflows have successfully completed (see [section 5](#5-concurrency-and-push-conflict-prevention) for a detailed explanation).

---

#### `era_wirck_intersections_run_queries.yml`
**Name:** Erasmus Pirckheimer Intersections – Setup MySQL, Import Data, and Run Queries

**Trigger:** Completion of either the Erasmus or the Pirckheimer DB & query workflow (whichever finishes last will pass the AND-gate)

**Steps:**
1. AND-gate check: query the GitHub API to verify that both the Erasmus and the Pirckheimer base workflows have completed successfully; abort if not
2. Check out the repository
3. Install Python dependencies
4. Create both databases (`era_cdb` and `wpirck_cdb`) in the same MySQL instance
5. Validate and import the Erasmus dataset
6. Validate and import the Pirckheimer dataset
7. Run intersection queries (`intersections_pirckheimer_erasmus/run_queries.py`) and save results to `intersections_pirckheimer_erasmus/query_results/`
8. Commit and push changes to `master`

---

#### `era_bude__intersections_run_queries.yml`
**Name:** Erasmus Budé Intersections – Setup MySQL, Import Data, and Run Queries

**Trigger:** Completion of either the Erasmus or the Budé DB & query workflow

**Steps:** identical in structure to the Era × Pirck intersection workflow above, targeting `era_cdb` + `bude_cdb` and `intersections_budé_erasmus/`.

---

### 3.4 Intersection workflows – R scripts

---

#### `era_wpirck_intersections_run_r_scripts.yml`
**Name:** Erasmus Pirckheimer Intersections – Run R Scripts and Save Outputs

**Trigger:** Completion of the Era × Pirck intersection DB & query workflow

**Steps:** same structure as the base R script workflows. Network animation scripts (under `*/create_network_animations/*`) are excluded from the automated run due to their long execution time. Outputs go to `intersections_pirckheimer_erasmus/r_plots/` and `intersections_pirckheimer_erasmus/leaflet_maps/`.

---

#### `era_bude__intersections_run_r_scripts.yml`
**Name:** Erasmus Budé Intersections – Run R Scripts and Save Outputs

**Trigger:** Completion of the Era × Budé intersection DB & query workflow

**Steps:** same structure as above, targeting `intersections_budé_erasmus/`.

---

## 4. Trigger and dependency map

The diagram below shows the complete dependency chain. An arrow means "triggers". Workflows at the same horizontal level can run in parallel.

```
 Push to                Push to                    Push to
 erasmus/csv            pirckheimer/csv             budé/csv
      │                       │                        │
      ▼                       ▼                        ▼
 Erasmus                Pirckheimer                  Budé
 DB & queries           DB & queries              DB & queries
      │                       │                        │
      ├───────────────────────┤                        │
      │                       │                        │
      ▼                       ▼                        ▼
 Erasmus               Pirckheimer                   Budé
 R scripts              R scripts                  R scripts
      │                       │
      └──────┬────────────────┘
             │  (AND: both must succeed)
             ▼
        Era × Pirck
        DB & queries
             │
             ▼
        Era × Pirck
         R scripts

      │
      └──────┬─────────────────────────────────────────┘
             │  (AND: Erasmus + Budé must both succeed)
             ▼
        Era × Budé
        DB & queries
             │
             ▼
        Era × Budé
         R scripts
```

> **Reading the diagram:** a single push to, say, `erasmus/dataset/csv/` will eventually cascade through five workflows — Erasmus DB & queries → Erasmus R scripts, and (once Pirckheimer and Budé have also passed their own AND-gates) Era × Pirck and Era × Budé intersections with their respective R script workflows.

---

## 5. Concurrency and push-conflict prevention

Because multiple workflows can be running at the same time and all commit to the same `master` branch, two mechanisms work together to prevent `push rejected` errors.

### AND-gate for intersection triggers

GitHub Actions' `workflow_run` trigger with multiple workflows listed uses OR logic: the workflow fires as soon as *any one* of the listed prerequisites completes. For intersection analyses, this is a problem — if only Erasmus has finished but Pirckheimer has not, running the intersection would use stale data.

The `check-prerequisites` job at the top of each intersection DB & query workflow solves this. Before any database work begins, it calls the GitHub API and checks whether both required base workflows show a recent successful run on `master`. If either one is missing, the job exits cleanly and the expensive MySQL job is never started. When the second base workflow then finishes and re-triggers the intersection workflow, both checks pass and the pipeline proceeds.

```
workflow_run fires (one of the two base workflows just finished)
       │
       ▼
check-prerequisites job
       │
       ├── both succeeded? ──► NO  ──► exit quietly, done
       │
       └── YES ──► setup-mysql job runs normally
```

### `git pull --rebase` before every push

Even with the AND-gate in place, some degree of parallelism remains — for instance, a base R script workflow and an intersection workflow may finish close together and both attempt to push to `master` at the same time. To handle this, every workflow's commit step pulls the latest remote state with `--rebase` before adding its own commit:

```bash
git pull --rebase https://x-access-token:${{ secrets.PAT_TOKEN }}@github.com/...  master
git add -A
git commit -m "..." || echo "No changes to commit"
git push ...
```

The rebase replays the local changes on top of any commits that arrived in the meantime, so the push always has a clean fast-forward path to `master`.

The two mechanisms are complementary: the AND-gate prevents structurally unnecessary parallel runs; the rebase handles the residual timing overlaps that cannot be fully eliminated.

---

## 6. Shared technical patterns

### The `setwd()` rewrite

R scripts in this repository use relative paths like `setwd("../query_results/")` so they can be run locally from within the script's own directory. Inside GitHub Actions the working directory is the repository root, which breaks these relative paths.

Each R script workflow therefore temporarily rewrites all `setwd()` calls to absolute paths before execution, then reverts them afterwards. This means the R scripts themselves remain unchanged in the repository and continue to work in both local and CI environments.

### Foreign key validation

Before any import, a Python script checks that all foreign key references in the CSV data are consistent (e.g. that every letter references a sender and recipient that actually exist in the persons table). This prevents silent data integrity issues from propagating into query results.

### Commented-out artifact uploads

All `actions/upload-artifact` steps are present in the workflow files but commented out. They were superseded by the direct `git commit` approach, which makes outputs immediately visible in the repository rather than requiring a separate artifact download step. The commented steps are kept for reference.

---

## 7. Manual execution

Every workflow includes a `workflow_dispatch` trigger, which means it can be started manually from the GitHub Actions tab without needing to push new data. This is useful for re-running a failed workflow, regenerating outputs after changes to R scripts or SQL queries, or testing a workflow in isolation.

When triggering an intersection workflow manually via `workflow_dispatch`, the AND-gate check is automatically bypassed — the workflow proceeds unconditionally, assuming the prerequisite data is already present in the repository.
