# VLBI Correlation Docker Tools

This repository contains some dockerized VLBI correlation tools:
* **Postprocessing**: MIT Haystack's [HOPS tools](https://www.haystack.mit.edu/haystack-observatory-postprocessing-system-hops/).
* **Configuration and conversion**: ATNF CSIRO's [DiFX tools](https://www.atnf.csiro.au/vlbi/dokuwiki/doku.php/difx/start).
* **Correlation**: [CXS338/CXPL38](https://github.com/ajvazquez/CXS338) correlator and tools (alpha, only for dev/testing).

The aim of this project is to provide lightweight images for quick and simple access to the tools displayed in the following diagram (Fig. 1 from the [CorrelX manual](https://github.com/MITHaystack/CorrelX/blob/master/correlx-user-developer-guide.pdf), page 8):
* CX: CXPL38 (pipeline) [cxp](cxp), and CXS338 (Spark) [cxs](cxs) - alpha, only dev/test.
* CX tools: CXPL ([cxp](cxp)) - alpha, only dev/test.
* DiFX tools: [vex2difx](vex2difx), [difxcalc](difxcalc), [difx2mark4](difx2mark4).
* HOPS: [hops](hops) (hops-cxs changes the correlator string for CXS).

![CX, DiFX tools, HOPS](cx_difx_hops.png)
(Fig. 1 from the [CorrelX manual](https://github.com/MITHaystack/CorrelX/blob/master/correlx-user-developer-guide.pdf), page 8)

For the most up-to-date/production versions or high performance deployments of these tools please refer to the [official repositories](#References) hosting these tools.

Once built, all the tools can be run for processing files on the host filesystem specifying the target folder.

## Tool Folder Structure

Every tool-associated folder provides the following files:
* ```build.sh```: Script for building the image.
* ```install.sh```: Script provided for convenience that builds the image and creates an alias in ```~/.bashrc``` starting with ```d-``` (e.g.: d-hops, d-cxs).
* ```run.sh```: Script for running a container, bypassing all parameters to the tool, and mounting the folder specified in the environment variable ```EXP``` in /tmp/data (if EXP is not defined the current path will be mounted).
  
The following scripts are only available for the HOPS image:
* ```run_x.sh```: Similar to run.sh, but using the host x-server (tested on Ubuntu host).

The following scripts are only available for the CXS/CXP images:
* ```run_dev.sh```: Similar to run.sh, but mounting a folder (specified in the script) with the sources from the host.
* ```run_jupyter.sh```: Launches a jupyterlab notebook, the main package being ```cxs``` (e.g.: from cxs.conversion.difx import cx2d_lib).

All ```run*.sh``` scripts can be run with the argument ```--docker-bash```, that allows to get into the docker container (intended for debugging).

## Images

Resulting images:
```
REPOSITORY     BASE          TAG                   SIZE
hops           [debian]      latest                145MB
hops-cxs       [debian]      latest                145MB
difxcalc       [debian]      latest                89.7MB
vex2difx       [debian]      latest                84.2MB
difx2mark4     [debian]      latest                63.4MB
cxp            [python]      latest                610MB
cxs            [spark]       latest                2.23GB
```

Base images:  
```
REPOSITORY                   TAG                   SIZE
debian                       stretch-slim          55.4MB
python                       3.8-slim-bullseye     124MB
bitnami/spark                latest                1.67GB
```

## Installation

1. Install Docker: https://docs.docker.com/
2. Run the ```build.sh``` script on the desired tool folder, or for convenience: ```bash install.sh && source ~/.bashrc```

The created aliases are as follows:
* d-hops CMD (e.g.: d-hops fourfit)
* d-difxcalc
* d-difx2mark4
* d-vex2dfix
* d-cxp CMD (e.g.: d-cxp cx-vdif-info)
* d-cxp-dev CMD (e.g.: d-cxp cx2d)
* d-cxp-jupyter
* d-cxs
* d-cxs-dev

Notes: 
* All paths in input files must be relative or absolute to /tmp/data/ (in the container), as that is the path where the dataset volume is mounted.
An example CXS338 configuration file is provided in cxs/examples/cxs338.ini using this path (all .ini files are expected to be in the EXP folder).
* Spark UI for CXS338 is accessible via browser on localhost:4040.
* Jupyterlab for CXPL38 is accessible via browser on localhost:8888.


## Examples

The following example is for HOPS:
```
# Installation:

$ cd hops
$ bash install.sh
[...]
Successfully tagged hops:latest
$ source ~/.bashrc 

# Execution:

$ EXP=/home/user/data/exp-1 d-hops fourfit ...
fourfit: 
fourfit: SYNTAX:  fourfit [-a] [-b BB:F] [-c controlfile] [-d display device] [-e]
[...]

# Or alternatively:

$ cd /home/user/data/exp-1
$ d-hops fourfit ...
fourfit: 
fourfit: SYNTAX:  fourfit [-a] [-b BB:F] [-c controlfile] [-d display device] [-e]
[...]

# Bash into container:

$ d-hops --docker-bash
docker-container $ fourfit ...
fourfit: 
fourfit: SYNTAX:  fourfit [-a] [-b BB:F] [-c controlfile] [-d display device] [-e]
[...]
```

## Disclaimer

CXS338, CXPL38, and this repository are prototypes / alpha.
For the most up-to-date/production versions or high performance deployments please refer to the [official repositories](#References) hosting these tools.

## References

* HOPS: https://www.haystack.mit.edu/haystack-observatory-postprocessing-system-hops/
* DiFX tools: https://www.atnf.csiro.au/vlbi/dokuwiki/doku.php/difx/start
* CXS (alpha): https://github.com/ajvazquez/CXS338
 
