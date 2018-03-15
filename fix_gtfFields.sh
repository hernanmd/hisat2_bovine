#!/bin/sh

# Fix for featureCount:
# Remove rows wit gene_id field missing
awk '{ if ($0 ~ "gene_id") print $0 }' \
	GCF_000003055.6_Bos_taurus_UMD_3.1.1_genomic.gtf > \
	GCF_000003055.6_Bos_taurus_UMD_3.1.1_genomic.IGEVET.gtf
