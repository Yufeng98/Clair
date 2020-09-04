# Download and extract the testing dataset
wget 'http://www.bio8.cs.hku.hk/testingData.tar'
tar -xf testingData.tar

# Download the Illumina model
wget http://www.bio8.cs.hku.hk/clair_models/illumina/12345.tar
tar -xf 12345.tar

# Create a folder for outputs
mkdir training

# Voila
python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 10269870 --ctgEnd 46672937 --only_prediction --time_counter_file_name time_counter_non_pipeline_1_thread.h5

# My prediction function
python3 my_prediction.py --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100

# chr22
python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr22/chr22.bam --ref_fn /z/scratch2/yufenggu/testingData/chr22/chr22.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr22 --ctgStart 10269870 --ctgEnd 46672937 --time_counter_file_name time_counter_non_pipeline_1_thread_chr22.h5

# print profiling result
python3 read_h5.py time_counter_non_pipeline_1_thread.h5
python3 read_h5.py time_counter_only_prediction.h5
python3 read_h5.py time_counter_non_pipeline_1_thread_chr22.h5