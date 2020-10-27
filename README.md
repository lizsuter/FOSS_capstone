# FOSS_capstone
Capstone project for FOSS 2020 workshop.

Instructions for using this repo:


### Set up an instance in Cyverse Atmosphere
- Used instance "Ubuntu 18_04 NoDesktop Base"
- large2 (CPU: 8, Mem: 48 GB, Disk: 320 GB root)



```
# Log Into Atmosphere
ssh <cyverse user name>@<Instance IP address>

# Set super user
sudo su

# Connect to Data Store using Cyverse credentials
iinit
#host name = data.cyverse.org
#port number = 1247
#zone = iplant

# Check mounted volumes
df -h 

# cd into mounted volume (/scratch in this case)
cd /scratch
ls

# Clone this repo
git clone https://github.com/lizsuter/FOSS_capstone.git


```

### Install Conda, Docker 
- Using instructions from [Foss Reproducibility Tutorial](https://learning.cyverse.org/projects/cyverse-cyverse-reproducbility-tutorial/en/latest/step2.html#install-conda)

### Back up to github
```
git status

# stage all changes 
git add .

# commit changes with a helpful message
git commit -am "update readme"

#push changes to github
git push
```

### Run pipeline
`run_pipeline.sh` sequence of events:
- runs SRA_toolkit container
- downloads fastq file from SRA and unpacks
- runs `kmer.py` which looks for DNA motifs of length `k` and counts how many times it finds them across the length of the read in bins of size `bin`
	- generates a count table, `motifs.csv`
- launches a container with RStudio in an html window. 
	- R version 3.6.2
	- tidyverse
- contains an R script for generating a heatmap from `motifs.csv`


First indicate names of variables, for example
```
SRA=SRR12485991
k=2
bin=10
```

Run pipeline (stdin 1 is SRA, 2 is kmer size, 3 is bin size in bp)
```
bash run_pipeline.sh SRR12485991 2 10
```

#### RStudio on the server,  see if you can see the files
- **If on local computer** go to `http://localhost:8787/`  
- **If on VM** go to `http://INSTANCE_IP_ADDRESS:8787/`
- rstudio and rstudio1 are the user name/ password
- make sure to Ctl+C to quit the docker image, or it will still be running even if you close the window


### Next Steps
- Play around in R
