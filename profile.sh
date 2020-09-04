#python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 0 --ctgEnd 10000000 --time_counter_file_name time_counter_non_pipeline_1_thread_ctg0.h5
#
#python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 10000001 --ctgEnd 20000000 --time_counter_file_name time_counter_non_pipeline_1_thread_ctg1.h5
#
#python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 20000001 --ctgEnd 30000000 --time_counter_file_name time_counter_non_pipeline_1_thread_ctg2.h5
#
#python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 30000001 --ctgEnd 40000000 --time_counter_file_name time_counter_non_pipeline_1_thread_ctg3.h5
#
#python3 clair.py callVarBam --chkpnt_fn ./model --bam_fn /z/scratch2/yufenggu/testingData/chr21/chr21.bam --ref_fn /z/scratch2/yufenggu/testingData/chr21/chr21.fa --call_fn ./training/chr21.vcf --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100 --ctgName chr21 --ctgStart 40000001 --ctgEnd 50000000 --time_counter_file_name time_counter_non_pipeline_1_thread_ctg4.h5


#python3 read_h5.py time_counter_non_pipeline_1_thread_chr22.h5
#python3 read_h5.py time_counter_non_pipeline_1_thread_ctg0.h5
#python3 read_h5.py time_counter_non_pipeline_1_thread_ctg1.h5
#python3 read_h5.py time_counter_non_pipeline_1_thread_ctg2.h5
#python3 read_h5.py time_counter_non_pipeline_1_thread_ctg3.h5
#python3 read_h5.py time_counter_non_pipeline_1_thread_ctg4.h5
#python3 read_h5.py time_counter_non_pipeline_1_thread.h5
python3 read_h5.py time_counter_non_pipeline_2_thread.h5
#python3 read_h5.py time_counter_non_pipeline_3_thread.h5
#python3 read_h5.py time_counter_non_pipeline_4_thread.h5
python3 read_h5.py time_counter_non_pipeline_5_thread.h5
python3 read_h5.py time_counter_non_pipeline_10_thread.h5
python3 read_h5.py time_counter_non_pipeline_15_thread.h5
python3 read_h5.py time_counter_non_pipeline_20_thread.h5
python3 read_h5.py time_counter_non_pipeline_25_thread.h5
python3 read_h5.py time_counter_non_pipeline_40_thread.h5
#python3 read_h5.py time_counter_my_prediction.h5
#python3 read_h5.py time_counter_only_prediction.h5



# Download and extract the testing dataset
wget 'http://www.bio8.cs.hku.hk/testingData.tar'
tar -xf testingData.tar

# Download the Illumina model
wget http://www.bio8.cs.hku.hk/clair_models/illumina/12345.tar
tar -xf 12345.tar
