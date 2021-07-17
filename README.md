# Phase-separation-sorted-patterned-ground
This repository provides the OpenCL and Matlab codes that simulate the phase separation model 1 and model 2 on our manuscript. "Ice needles weave patterns of stones in frozen landscapes" by Anyuan Li, Norikazu Matsuoka, Fujun Niu, Jing Chen, Zhenpeng Ge, Wensi Hu, Desheng Li, Bernard Hallet, Johan van de Koppel, Nigel Goldenfeld, and Quan-Xing Liu (2021), under review in PNAS.

## Guide for code 
* Matlab fold includes the Matlab code on the derivation of the potential functions on theoretical models.

* OpenCL fold includes the C++ code with cmake file to numerical results of self-organized patterns from Model 1 and Model 2 described in Supplementary Information. [OpenCL](http://en.wikipedia.org/wiki/OpenCL) is used as the computation engine, to take advantage of the spatial meshgrid on graphics cards and modern CPUs.

* R_code fold includes data statistical analyses and figures generated with RStudio.

## Models with Quadratic speed 
* The fold includes the codes to simulate phase separation with Quadratic speed listed in Table S2 (Formula 2). We saw that the predicted conclusions were independent of the specific formula of speed function by exponent formula and Quadratic form. Hence, we just show the results that arise from the exponent function here in the main paper.


## Code Availability 
The full codes and experimental data will be available once the original article acceptance. 

## Data availability
Where to obtain the data for the plot? We only keep the code here for convenience. The data of about 2.5 GB will be available at the Zenodo repository (coming soon).
