# README

This folder is a working directory used by the custom modelling toolbox **Data2Dynamics** in MATLAB. The corresponding git repository is found [HERE](https://github.com/Data2Dynamics/d2d). 

In order to run the code in this repository, one needs to download the **d2d** toolbox and initialize it. 
The installation process and system requirements are described [HERE](https://github.com/Data2Dynamics/d2d/wiki/Installation).

The model analyses were conducted on a *Windows 10* operating system under *MATLAB R2021b*. The **d2d** version used in the analyses corresponded to the git commit hash *10a50ef01740889edb1064f5c11b439b46f10c77* , but later versions should still work. In case you download and work with a later version of **d2d**, you can switch to the mentioned version via ``arGetOldRevision('10a50ef01740889edb1064f5c11b439b46f10c77')``, type ``help arGetOldRevision`` for more details.

While the installation only requires the download of the *d2d* toolbox and correct initialization, the analyses require a compiled version of the specific model used. After initialization of the general toolbox, a Setup file in this repository needs to be executed in Matlab in order to load the mathematical model together with the data into one object, which is used for the model analyses. This compilation process can take multiple hours on a standard computer, but only has to be done once for each model.

A demo example of a standard analysis could be done by executing the following lines of code in Matlab:

```
Setup_withspdef;
arLoadPars('20240325T112126_withspdef');
arPlot;
```

This code compiles the model (model 2 in the paper), loads in the parameters for which the simulated mathematical model best describe the data and plots the results. Note that upon first running the code, this takes about 2 hours due to compilation of the model.

