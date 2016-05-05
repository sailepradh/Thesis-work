#!/bin/bash -l
#SBATCH -A b2015105
#SBATCH -t 30:00:00
#SBATCH -J P4105_201_post-alignment
#SBATCH -n 4 -p core 
#SBATCH -C thin
#SBATCH -e /proj/b2015105/nobackup/P4105_201_S1/info/P4105_201_S1_post_alignment.err
#SBATCH -o /proj/b2015105/nobackup/P4105_201_S1/info/P4105_201_S1_post_alignment.out
#SBATCH --mail-type=All
#SBATCH --mail-user=sailendra.pradhananga@scilifelab.se

index=/proj/b2015105/scripts/GATKbundle/
input=/proj/b2015105/INBOX/P4105/P4105_201/02-FASTQ/160405_ST-E00201_0074_AHLL3GCCXX/
output=/proj/b2015105/nobackup/P4105_201_S1/
picard=/sw/apps/bioinfo/picard/1.127/milou/picard.jar
GATK=/sw/apps/bioinfo/GATK/3.3.0/GenomeAnalysisTK.jar


module load bioinfo-tools samtools java

samtools view -bS -h -F 1024 ${output}P4105_201_S1.sorted.marked.bam > ${output}P4105_201.sorted.marked.PCRremoved.bam

#rm -v ${output}P4105_201_S1.sorted.marked.bam

samtools flagstat ${output}P4105_201.sorted.marked.PCRremoved.bam > ${output}stderr_samtoolsFlagstat_PCR_duplicates_markduplicates.log.txt

java -Xmx5g -jar $picard AddOrReplaceReadGroups MAX_RECORDS_IN_RAM=2500000 INPUT=${output}P4105_201.sorted.marked.PCRremoved.bam OUTPUT=${output}P4105_201.rgInfoFixed.bam CREATE_INDEX=true RGID=P4105_201 RGLB=P4105_201 RGPL=illumina RGSM=P4105_201 RGCN="SciLifeLab" RGPU="barcode"  1>&2  2> ${output}stderr.addAndReplaceReadGroups.log.txt

rm -v ${output}P4105_201.sorted.marked.PCRremoved.bam

echo -e "-> BaseRecalibrator <-"
java -Xmx5g -jar $GATK -T BaseRecalibrator -I ${output}P4105_201.rgInfoFixed.bam -R ${index}human_g1k_v37.fasta -o ${output}P4105_201.BQSR.grp -cov ReadGroupCovariate -cov QualityScoreCovariate -cov CycleCovariate -cov ContextCovariate -knownSites ${index}dbsnp_138.b37.vcf 1>&2 2> ${output}stderr.baseRecalibrator.txt

echo -e "-> PrintReads <-"
java -Xmx5g -jar $GATK -T PrintReads -baq CALCULATE_AS_NECESSARY -I ${output}P4105_201.rgInfoFixed.bam -R ${output}human_g1k_v37.fasta -BQSR ${output}P4105_201.BQSR.grp  -o ${output}P4105_201.baseRecalibator.bam 1>&2 2> ${output}stderr.printreads.txt 
