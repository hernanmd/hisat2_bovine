# Description

Scripts to index and align Bovine genome with HISAT2

The scripts in this repository enables to index and align a Bovine NGS dataset with the UMD3.1.1 Bovine Genome

# Details

Before running, please open the scripts and customize for the amount of cores (threads) in your platform.

## make_bgumd31.sh

Use the script to index the UMD3.1.1 Bovine Genome with the HISAT2 software.

## run_Hisat2.sh

Use the script to map the cleaned reads with the genome index built from the previous script.

## install_ReSeQC.sh

Use the script if installing ReSeQC in the officially documented way does not work. The script assumes nothing about the target destination, except being a Debian-compatible Linux distribution. It requires root privilege to install dependencies.

## fix_gtfFields.sh

Use this script if running featureCounts results in the following message:

> Warning: failed to find the gene identifier attribute in the 9th column of the provided GTF file.
> The specified gene identifier attribute is 'gene_id'
> The attributes included in your GTF annotation are 'transcript_id "rna...";'

The script removes all rows without the gene_id annotation in the last field of a GTF record.

