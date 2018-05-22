#!/bin/sh

# Automate HISAT2 index build for Bovine genome (UMD 3.1.1 assembly)
# Author: 
#  Hernan Morales Durand <hernan.morales@gmail.com>
#  Tatiana Zieglert
# Requires chromosome list files and exon/ss files to be already present in the current directory

# Threads setting
threads=32


# Uncompress exon/ss files
tar zxvf GCF_HISAT2.tar.gz
# Download genome
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/055/GCF_000003055.6_Bos_taurus_UMD_3.1.1/GCF_000003055.6_Bos_taurus_UMD_3.1.1_genomic.fna.gz
# Download annotations in GFF format
# wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/055/GCF_000003055.6_Bos_taurus_UMD_3.1.1/GCF_000003055.6_Bos_taurus_UMD_3.1.1_genomic.gff.gz
# Uncompress genome
gunzip GCF_000003055.6_Bos_taurus_UMD_3.1.1_genomic.fna.gz
# Download faSplit
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/faSplit; chmod 755 faSplit
# Split genome in current directory
./faSplit byname GCF_000003055.6_Bos_taurus_UMD_3.1.1_genomic.fna .

# Build index without Unplaced sequences
gcf_ac=$(cat GCF_AC.txt)
hisat2-build \
        -p $threads \
        --ss GCF_UMD3.1_ss.txt \
        --exon GCF_UMD3.1_ex.txt \
        -f $gcf_ac UMD3.1.1.AC.idx

# Build index with all Unplaced sequences
gcf_acnw=$(cat GCF_ACNW.txt)
hisat2-build \
        -p $threads \
        --ss GCF_UMD3.1_ss.txt \
        --exon GCF_UMD3.1_ex.txt \
        -f $gcf_acnw UMD3.1.1.ACNW.idx
