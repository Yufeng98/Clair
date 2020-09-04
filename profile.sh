#python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 0 --ctgEnd 10000000 --time_counter_file_name time_counter_non_pipeline_1_thread_ctg0.h5
#
#python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 10000001 --ctgEnd 20000000 --time_counter_file_name time_counter_non_pipeline_1_thread_ctg1.h5


# Download and extract the testing dataset
wget 'http://www.bio8.cs.hku.hk/testingData.tar'
tar -xf testingData.tar

# Download the Illumina model
wget http://www.bio8.cs.hku.hk/clair_models/illumina/12345.tar
tar -xf 12345.tar

mkdir training

# Use cProfile to find the most time consuming functions
python3 -m cProfile -o cProfile.txt clair.py callVarBam --chkpnt_fn ./model --bam_fn testingData/chr21/chr21.bam --ref_fn testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 10269870 --ctgEnd 46672937

# Store intermediate data with --store_loaded_mini_match
python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn testingData/chr21/chr21.bam --ref_fn testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 10269870 --ctgEnd 46672937 --store_loaded_mini_match

