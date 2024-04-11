arInit
ar.config.checkForNegFluxes = 0;  
% Load Model 1 in the paper:
% arLoadModel('spdef__spdef_on_foxa1__omit_spdef.def')
% Load Model 2 in the paper:
arLoadModel('spdef__spdef_on_foxa1__notchOnTp63.def')
arLoadData('RNAseq_data_WT_controls_correctedTimes');
arLoadData('cellQuant_data_ctrl_absNums');    
arLoadData('cell_prior');
arCompileAll();
arSetParsPattern('hill_',log10(2),1,1,0,1);

%arLoadPars('20221215T140647_notchOnTp63');

%arSetPars('prod_multi_prog',-2.5,1,1,-5,-1);
%arSetPars('prolif_multi_prog',0,1,0,0,1);
%arSetPars('km_mcc_off_hes5_delta',0,1,1,-5,3);
%arSetPars('km_ssc_off_hes4_delta',0,1,1,-5,3);
