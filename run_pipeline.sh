#!/bin/bash

# User-defined variables from stdin
SRA=$1
kmer=$2
bin=$3

#################################################################
# Download and install all necessary packages for project
#################################################################

# Update ubuntu apt-get package manager
sudo apt-get update

# Install some needed packages
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common

# Add the Docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the repository
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"

# Update apt-get with new repository information
sudo apt-get update

# Install docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install pandas
sudo apt-get -y install python-pandas

#################################################################
# Install SRA files using SRA_toolkit docker
#################################################################

#create folder (untracked) for sra data to download
mkdir raw_data

# download the .sra file
echo -e "\e[32m\nSRA downloading\n\e[0m"

docker run -v /scratch/FOSS_capstone/raw_data/:/raw_data/ \
quay.io/biocontainers/sra-tools:2.10.0--pl526he1b5a44_0 \
prefetch -p 1 $SRA --output-directory /raw_data/

# unpack the paired-end fastq files from .sra file
echo -e "\e[32m\nsplitting SRA into paired fastq files\n\e[0m"

docker run -v /scratch/FOSS_capstone/raw_data/$SRA/:/fastq_data/ \
quay.io/biocontainers/sra-tools:2.10.0--pl526he1b5a44_0 \
fastq-dump --split-files --origfmt ${SRA} --outdir /fastq_data/

# Run Python script to summarize kmer content of reads
echo -e "\e[32m\nanalyzing kmer content of fastq files\n\e[0m"

cd /scratch/FOSS_capstone/raw_data/$SRA/

for fastq in *.fastq;
do
  python /scratch/FOSS_capstone/tools/kmer.py $fastq $kmer $bin
done

# Launch RStudio+ Tidyverse container
echo -e "\e[32m\nlaunching Rstudio\n\e[0m"

docker run -v /scratch/FOSS_capstone/:/home/rstudio/work -e PASSWORD=rstudio1 -p 8787:8787 rocker/tidyverse:3.6.3

