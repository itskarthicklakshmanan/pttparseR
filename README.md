pttparseR
=========

A simple R and SHINY package based interface to parse ptt file and visualize bacterial genome


## Requirement:

Shiny package installed in R

library(shiny)


### Run a tar or zip file directly
runUrl("https://github.com/karthicklaksman/pttparseR/archive/master.tar.gz")
runUrl("https://github.com/karthicklaksman/pttparseR/archive/master.zip")

Or you can clone the git repository, then use runApp():

### First clone the repository with git. 
f you have cloned it into ~/pttparseR, first go to that directory, then use runApp().
setwd("~/pttparseR")
runApp()


### GUI Usage help:

Copy paste ptt file link with organism folder from ncbi ftp site.
go to site: ftp://ftp.ncbi.nlm.nih.gov/genomes/Bacteria/

Paste the organism directory and ptt file line as shown below, in the add link text box
Acaryochloris_marina_MBIC11017_uid58167/NC_009930.ptt


