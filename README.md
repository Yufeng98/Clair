## Installation

### Option 1. Bioconda

```bash
# make sure channels are added in conda
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# create conda environment named "clair-env"
conda create -n clair-env -c bioconda clair
conda activate clair-env

# store clair.py PATH into $CLAIR variable
CLAIR=`which clair.py`

# run clair like this afterwards
python $CLAIR --help
```

The conda environment has the Pypy3 interpreter installed, but one Pypy3 package `intervaltree` is still missing. The reason why this is not installed by default is because this is not yet available in any conda repositories. To install the package for Pypy3, after activating the conda environment, please run the following commands:

```bash
pypy3 -m ensurepip
pypy3 -m pip install --no-cache-dir intervaltree==3.0.2
```

Then download the trained models:

```bash
# download the trained model for ONT
mkdir ont && cd ont
wget http://www.bio8.cs.hku.hk/clair_models/ont/122HD34.tar
tar -xf 122HD34.tar
cd ../

# download the trained model for PacBio CCS
mkdir pacbio && cd pacbio
wget http://www.bio8.cs.hku.hk/clair_models/pacbio/ccs/15.tar
tar -xf 15.tar
cd ../

# download the trained model for Illumina
mkdir illumina && cd illumina
wget http://www.bio8.cs.hku.hk/clair_models/illumina/12345.tar
tar -xf 12345.tar
cd ../
```

### Option 2. Build an anaconda virtual environment step by step
#### Please install anaconda using the installation guide at https://docs.anaconda.com/anaconda/install/

```bash
# create and activate the environment named clair
conda create -n clair python=3.7
conda activate clair

# install pypy and packages on clair environemnt
conda install -c conda-forge pypy3.6
pypy3 -m ensurepip
pypy3 -m pip install intervaltree==3.0.2

# install python packages on clair environment
pip install numpy==1.18.0 blosc==1.8.3 intervaltree==3.0.2 tensorflow==1.13.2 pysam==0.15.3 matplotlib==3.1.2
conda install -c anaconda pigz==2.4
conda install -c conda-forge parallel=20191122 zstd=1.4.4
conda install -c bioconda samtools=1.10 vcflib=1.0.0 bcftools=1.10.2

# clone Clair
git clone --depth 1 https://github.com/HKU-BAL/Clair.git
cd Clair
chmod +x clair.py
export PATH=`pwd`":$PATH"

# store clair.py PATH into $CLAIR variable
CLAIR=`which clair.py`

# run clair like this afterwards
python $CLAIR --help
```

Then download the trained models referring to `download the trained model` in [Installation - Option 1](#option-1-bioconda)

### Option 3. Docker

```bash
# clone Clair
git clone --depth 1 https://github.com/HKU-BAL/Clair.git
cd Clair

# build a docker image named clair_docker_image
docker build -f ./Dockerfile -t clair_docker_image . # You might need root privilege

# run docker image
docker run -it clair_docker_image # You might need root privilege

# store clair.py PATH into $CLAIR variable
CLAIR=`which clair.py`

# run clair like this afterwards
python $CLAIR --help
```

Then download the trained models referring to `download the trained model` in [Installation - Option 1](#option-1-bioconda)


### After Installation

Run command
```shell
# download models
wget http://www.bio8.cs.hku.hk/clair_models/illumina/12345.tar
tar -xf 12345.tar
python3 my_prediction.py --chkpnt_fn ./model --sampleName HG001 --pysam_for_all_indel_bases --threads 1 --qual 100
```
