# FOSS_capstone
Capstone project for FOSS 2020 workshop


### Set up instance in Cyverse Atmosphere
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

# cd into /scratch
cd /scratch
ls

# Connect to github
git clone https://github.com/lizsuter/FOSS_capstone.git


```

### Install Conda, Jupyterlab, Docker 
- Using instructions from [Foss Reproducibility Tutorial](https://learning.cyverse.org/projects/cyverse-cyverse-reproducbility-tutorial/en/latest/step2.html#install-conda)

### Back up to github
```
git status

# commit changes with a helpful message
git commit -am "update readme"

#push changes to github
git push
```


