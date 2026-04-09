# Usage

This documentation describes how to run the **nfixplanet workflow**, a Nextflow pipeline designed to identify and annotate nitrogen fixation genes from genomic or metagenomic assemblies. The workflow integrates three main steps:

1. Gene prediction using Prodigal  
2. Functional screening using HMM profiles (hmmscan)  
3. Annotation using nfixplanet  

## CLI

A typical command to run the workflow is:

```bash
nextflow run nfixplanet --input ./genomes --output_dir ./results
```

## Input

The workflow expects genomic FASTA files as input.

### Supported formats:
- `.fa`
- `.fasta`
- `.fna`
- Compressed versions (e.g., `.fa.gz`, `.fasta.gz`)

### Input parameter:
- `--input:` Path to a FASTA file or a directory containing FASTA files
