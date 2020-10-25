SRA=SRR12485991

# cd into /scratch
cd /scratch
ls

# Connect to github
git clone https://github.com/lizsuter/FOSS_capstone.git

# Install Conda, Jupyterlab, Docker
# steps go here

# Install SRA files using SRA_toolkit docker
# download the .sra file
docker run -v /scratch/FOSS_capstone/raw_data/:/raw_data/ \
quay.io/biocontainers/sra-tools:2.10.0--pl526he1b5a44_0 \
prefetch -p 1 $SRA --output-directory /raw_data/

# unpack the paired-end fastq files from .sra file
docker run -v /scratch/FOSS_capstone/raw_data/$SRA/:/fastq_data/ \
quay.io/biocontainers/sra-tools:2.10.0--pl526he1b5a44_0 \
fastq-dump --split-files --origfmt ${SRA} --outdir /fastq_data/

# Run Python script to summarize kmer content of reads
cd /scratch/FOSS_capstone/raw_data/$SRA/

for fastq in *.fastq;
do
  python3 /scratch/FOSS_capstone/tools/kmer.py $fastq 2 10
done

# Test out RStudio+ Tidyverse docker

# make a testfile
touch test.file
cd ..

# launch the container,  see if you can see the test.file
docker run -v /scratch/FOSS_capstone/:/home/rstudio/work -e PASSWORD=rstudio1 -p 8787:8787 rocker/tidyverse

