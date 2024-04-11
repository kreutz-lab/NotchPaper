arInit
ar.config.checkForNegFluxes = 0;    
% Load Model 2.1 in the paper:
arLoadModel('Notch_GoFLoF_mppconversion_cellprod')
arLoadData('RNAseq_data_WT_controls_correctedTimes_timetrafo'); 
arLoadData('cell_prior_timetrafo3');
arLoadData('Controls_Cells_timetrafo_only_new');
arLoadData('GainOfFunction_Cells_hes4_15conc_timetrafo');
arLoadData('GainOfFunction_Cells_hes5_15conc_timetrafo');
arLoadData('GainOfFunction_Cells_hes7_15conc_timetrafo');
arLoadData('LossOfFunction_Cells_hes4_timetrafo');
arLoadData('LossOfFunction_Cells_hes5_timetrafo');
arLoadData('LossOfFunction_Cells_hes7_timetrafo');
arCompileAll;

% Since the optimization problem is computationally expensive, decrease the
% ODE integration tolerances and terminate at smaller step size to find
% quick approximately correct fits
ar.config.optim.TolX = 10^-4;
ar.config.optim.Display = 'iter';
ar.config.atol = 10^-5;
ar.config.rtol = 10^-5;
ar.config.maxsteps = 2000;