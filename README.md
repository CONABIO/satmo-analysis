## satmo-analysis

Repository to centralize all analysis, tests, proofs of concept, ..., related to the satmo system. IN the form of scripts and notebooks.

### Organization

- The `data` directory should only contain small datasets, useful for testing algorithms locally without having to loggin to the server
- Actual satmo data are stored on the `data2` drive. It is mounted on the `coral` server (and others), so that most path present in the scripts and notebooks assume data access is made from `coral`.
- `R` directory contains R notebooks and scripts
- `R/R` directory contains functions
- `python` directory contains jupyter notebooks and python scripts 