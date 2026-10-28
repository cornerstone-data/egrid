# Fork notes

This repository is a fork of [USEPA/egrid](https://github.com/USEPA/egrid), maintained independently at [cornerstone-data/egrid](https://github.com/cornerstone-data/egrid). Full upstream git history is retained so original authors remain credited. The original MIT license and copyright notice in [LICENSE.md](LICENSE.md) are unchanged.

## Relationship to upstream

- Changes are not sent upstream as pull requests.
- Upstream fixes may be cherry-picked as needed; regular merges become harder as the code diverges.
- Supported data years: 2018 and later.

## Divergences from upstream

Add an entry here whenever this fork's behavior departs from upstream (date, files, reason).

- Puerto Rico 860m sheets and header row are detected by vintage instead of assumed; a warning is raised when Puerto Rico is absent (`scripts/1_production_model/data_clean_eia.R`).
- Output metadata links point to this repository rather than USEPA/egrid.
