#! /bin/bash
#$ -cwd
#$ -l h_rt=4:00:00,h_data=4G
#$ -N vcfFilter
#$ -o /u/scratch/p/pkalhori
#$ -e /u/scratch/p/pkalhori
#$ -m abe
#$ -M pkalhori
#$ -t 1-2

#Daniel_vcfdir=/u/project/rwayne/software/rails/VCF_FILES_MISSING_SITES

vcfdir=/u/scratch/p/pkalhori/rails/VCFs_Missing_sites_Test
#mkdir -p $vcfdir

source /u/local/Modules/default/init/modules.sh
module load samtools
module load bcftools

allVCF=Neutral_sites_SFS_ALL_${SGE_TASK_ID}.vcf.gz

#cp $Daniel_vcfdir/$allVCF $vcfdir

#gunzip $vcfdir/$allVCF ##it must be unzipped

allVCF_unzipped=Neutral_sites_SFS_ALL_${SGE_TASK_ID}.vcf

#extract only SNPs
newVCF=Neutral_sites_monomorphic_removed_${SGE_TASK_ID}.vcf
#bcftools view -m2 -M2 -v snps --min-ac 1:minor ${vcfdir}/${allVCF_unzipped} > ${vcfdir}/${snpVCF}
bcftools view -a -c 1:nref ${vcfdir}/${allVCF_unzipped} > ${vcfdir}/${newVCF}
