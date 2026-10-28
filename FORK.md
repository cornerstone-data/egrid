# Fork notes

This repository is a fork of [USEPA/egrid](https://github.com/USEPA/egrid), maintained independently at [cornerstone-data/egrid](https://github.com/cornerstone-data/egrid). Full upstream git history is retained so original authors remain credited. The original MIT license and copyright notice in [LICENSE.md](LICENSE.md) are unchanged and continue to cover the upstream code. Fork modifications after `868b42b` are under [LICENSE-CORNERSTONE.txt](LICENSE-CORNERSTONE.txt).

## Fork point

The `main` branch of this repository reflects the code in the `development` branch of USEPA/egrid at upstream commit `868b42b` ("Updating read of EPA API data."). The upstream `main` branch at that time (`08eddc7`, 2025-06-12) was older than that `development` head, so `development` was merged into `main` here. All commits after `868b42b` are specific to this fork.

## Relationship to upstream

- Changes are not sent upstream as pull requests.
- Upstream fixes may be cherry-picked as needed; regular merges become harder as the code diverges.
- Supported data years: 2018 and later.

## Divergences from upstream

Add an entry here whenever this fork's behavior departs from upstream (date, files, reason).

- Puerto Rico 860m sheets and header row are detected by vintage instead of assumed; a warning is raised when Puerto Rico is absent (`scripts/1_production_model/data_clean_eia.R`).
- Output metadata links point to this repository rather than USEPA/egrid.
- 2025 (2026-10-28): OTH fuel codes from Open Grid Emissions (`updated_oth_energy_source_codes.csv`) adopted for three plants in `og_oth_units_to_change_fuel_type.csv`: Neptune Gas Processing 56139 (OG), Chalmette Refining 50626 (PC), Kapaia 56258 (DFO). OGE's MSB codes for the phosphate plants 54472 and 50474 were not adopted, because their OTH units burn sulfur.
- 2025 (2026-10-28): `og_oth_units_to_change_fuel_type.csv` is filtered to the eGRID year in the generator and plant files, and `epa_plants_to_delete.csv` to `year <= eGRID year` in the generator file, matching the unit file. Upstream read all years, so a plant's later-year rows affected earlier runs.
- 2025 (2026-10-28): the previous-year eGRID for 2025 runs is Cornerstone eGRID 2024 from Zenodo (metric workbook; EPA did not publish eGRID2024) (`function_download_historical_egrid.R`).
- 2025 (2026-10-28): grid gross loss falls back to the previous year's EIA State Electricity Profiles when the eGRID year is not yet published (`grid_gross_loss_create.R`). The 2025 run uses 2024 GGL until EIA publishes 2025.
- 2025 (2026-10-28): plant-level lat/lon corrections in `manual_corrections.xlsx` were given a year (2025). Upstream left the year blank, so the `year >= eGRID year` filter dropped them.
