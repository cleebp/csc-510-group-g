# scripts
This directory contains all the scripts used to collect the data, anonymize the data, transform the data, and to generate graphs.


- ```gitable.conf```: This file contains a GitHub authenication code used to get data from GitHub.
- ```gitable.py```: This is the script that collects all the data from GitHub, using their official API. It also anonymizes the data, replacing the group letters with numbers, as well as the usernames with generic usernames. It collects data from the following areas:
  -    Issues
  -    Milestones
  -    Comments
  -    Commits
- ```run.sh```: This is a script that generates the data dumps from the databsae files.
- ```stats.sh```: This is the script that generates the csv files from the data dump.
- Rscripts: This is a directory that contails all the scripts used to generate the graphs in R.
