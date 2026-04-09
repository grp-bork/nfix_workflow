# NFixPlanet workflow

#### Description

NFixPlanet is a Nextflow workflow for the identification and annotation of nitrogen fixation (nif) genes in prokaryotic genomes or metagenomic assemblies. The workflow runs gene prediction with `Prodigal`, followed by homology-based annotation using `HMMER` against a curated HMM profile, and finally annotates the results using the `nfixplanet` tool.

---

# Overview

1. Predict genes ([`Prodigal`](https://github.com/hyattpd/Prodigal)) — runs in metagenomic mode (`-p meta`); supports both plain and gzip-compressed FASTA input
2. Search predicted genes against an HMM profile ([`HMMER hmmscan`](http://hmmer.org/))
3. Annotate HMM hits ([`nfixplanet`](https://github.com/grp-bork/nfixplanet))

---

# Usage

## Command-Line Interface (CLI)

```bash
nextflow run main.nf \
    --input  \
    --output_dir  \
    --hmm_profile 
```

## Parameters

| Parameter | Description | Required |
|-----------|-------------|----------|
| `--input` | Path to input FASTA file (plain or `.gz`) | ✅ |
| `--output_dir` | Path to output directory | ✅ |

## Output files

All output files are written to `--output_dir`:

| File | Description |
|------|-------------|
| `hmm_output.tbl` | HMMER tabular output of gene-to-HMM hits |
| `annotations/*` | nfixplanet annotation results |

---

# Citation

If you use this workflow, please cite the tools it depends on:

```
Hyatt D, Chen GL, LoCascio PF, Land ML, Larimer FW, Hauser LJ. Prodigal: prokaryotic gene recognition and translation initiation site identification. BMC Bioinformatics. 2010;11:119. doi:10.1186/1471-2105-11-119

Eddy SR. Accelerated Profile HMM Searches. PLoS Comput Biol. 2011;7(10):e1002195. doi:10.1371/journal.pcbi.1002195
```