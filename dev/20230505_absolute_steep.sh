#===============================================================================
#
#         FILE: /Users/alecsteep/Documents/ABSOLUTE/dev/20230505_absolute-main_steep.sh
#        USAGE: Documentation script
#
#  DESCRIPTION:  Documentation script for workflow
# REQUIREMENTS:  ---
#        NOTES:  
#       AUTHOR:  Alec Steep, steepale@uchicago.edu
#  AFFILIATION:  Genomic Data Commons (GDC) at The University of Chicago
#      VERSION:  1.0
#      CREATED:  2023.05.05
#     REVISION:  ---
#===============================================================================

# Set the working directory
WD='/Users/alecsteep/Documents/ABSOLUTE/'

# Clone the github repo
git clone https://github.com/lmogil/ABSOLUTE.git

# Switch to Lauren's Branch
git checkout new_docker

# Run the deploy script (this builds thee Docker image)
# The build takes 10+ min
sh ${WD}/deploy.sh

# Examine docker image
docker image ls


#################################################
######## Collect Example MAF & Seq Files ########
#################################################

# seg file d07a6bf3-4297-40f1-a56b-7be5098a03ac
# aliquot level maf a8935587-7af0-4c2f-b5df-cf212b0970d2

# The input data are protected ensembl MAFs from a project (CTSP-DLBCL1)
# Files were downloaded from the GDC portal: https://portal.gdc.cancer.gov

# Jump to thor0
ssh -A ubuntu@172.21.21.144
ssh_thor0

 # Navigate to your folder in home
cd /home/ubuntu/steepale/ABSSOLUTE

# With reverse search, type download
sudo /home/ubuntu/.virtualenvs/p2/bin/cwltool  ~/bio_client_download.cwl --config-file ~/bioclient.json --download_handle d07a6bf3-4297-40f1-a56b-7be5098a03ac
sudo /home/ubuntu/.virtualenvs/p2/bin/cwltool  ~/bio_client_download.cwl --config-file ~/bioclient.json --download_handle a8935587-7af0-4c2f-b5df-cf212b0970d2

# Rsync the files to vm (from vm)
rsync -av --progress 172.21.16.124:/home/ubuntu/steepale/ABSOLUTE/* \


# Rsync files to personal mac (from mac)
rsync -av --progress \
172.21.41.17:/mnt/Documents/ABSOLUTE/data/590b6405-9315-4c6f-97a2-43d606cbe0e8.wgs.GATK4_MuTect2_Pair.aliquot.maf.gz \
/Users/alecsteep/Documents/ABSOLUTE/dev/data/


#################################################
######## Begin to understand the R Script #######
#################################################

# Enter the docker image and perform dev work in R environment
docker run --rm -it \
--entrypoint="/bin/bash" \
-v /Users/alecsteep/Documents/ABSOLUTE/:/Users/alecsteep/Documents/ABSOLUTE/ \
9b270fd57086

# Create a mock R Markdown file to test R script
# PATH: ${WD}/dev/ABSOLUTE_cli_start__steep.Rmd (replica of another file in repo)




