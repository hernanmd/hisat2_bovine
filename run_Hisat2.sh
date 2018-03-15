#!/bin/bash

echo "Removing old .log files"
rm -v *.log

# List R1 and R2 files in separate arrays, delimiting each fastq file with commas
r2_files=$(find *_L00*_R2_* | tr '\n' ,)
r1_files=$(find *_L00*_R1_* | tr '\n' ,)

# Remove last comma
r2_files="${r2_files%?}"
r1_files="${r1_files%?}"

# Set splice site file
#ss_file="Ensembl79_UMD3.1_genes_splice_sites.txt"
ss_file="BosTaurus_UMD3.1_genes_splice_sites.txt"
# Set output file name prefix
idx_baseName="UMD3.1.1.AC.idx"

# Convert String delimited line to Array
IFS="," read -r -a r1_array <<< "$r1_files"
IFS="," read -r -a r2_array <<< "$r2_files"

# Display how many reads were found for each array
echo "R1 FILES = "${#r1_array[@]}
echo "R2 FILES = "${#r2_array[@]}

[ ${#r1_array[@]} -gt ${#r2_array[@]} ] && { echo "More R1 than R2 files were read"; exit 1; }
[ ${#r1_array[@]} -lt ${#r2_array[@]} ] && { echo "More R2 than R1 files were read"; exit 1; }

# Iterate over the reads and map
for ((i = 0; i < ${#r1_array[@]};++i)); do
	bamFile=$(echo "${r1_array[i]}" | sed 's/_R1_001.fastq.gz//')".bam"
	echo "Aligning (no. $i)"
	echo  "-1 = ${r1_array[i]}"
	echo  "-2 = ${r2_array[i]}"
	echo "Creating new BAM: "$bamFile
	hisat2 -t -p 32 -x $idx_baseName \
		--summary-file ${r1_array[i]}_summary_$i.log \
		--known-splicesite-infile $ss_file \
		--met-file ${r1_array[i]}_metrics_$i.log \
		-1 ${r1_array[i]} \
		-2 ${r2_array[i]} | \
		samtools view -@ 32 -Sbo $bamFile -
done
