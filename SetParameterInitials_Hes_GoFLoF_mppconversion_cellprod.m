% This script primarily sets initial parameter values, hard parameter 
% bounds and parameter priors for the 2.1. Model
%
% This script is utilized to start from a good initial guess for fitting
% and simplify the fitting problem with priors. Randomly sampling initial
% guesses was not a viable solution to this optimization problem, so
% parameter values needed to be fine-tuned by hand and if optima were not
% found in the process, adjustments to temporary fits have been to be made.

% arSetPars(pLabel, [p], [qFit], [qLog10], [lb], [ub], [type], [meanp], [stdp])

arSetParsPattern('deg',-2,1,1,-4,1);
arSetPars('deg_hes4_rna_fc',0,0,1,-2,2);
arSetPars('deg_hes5_rna_fc',0,0,1,-2,2);
arSetPars('deg_hes7_rna_fc',0,0,1,-2,2);
arSetPars('deg_hes4_prot_fc',0,1,1,-2,2,1,0,1);
arSetPars('deg_hes5_prot_fc',0,1,1,-2,2,1,0,1);
arSetPars('deg_hes7_prot_fc',0,1,1,-2,2,1,0,1);
arSetPars('hes_delay',log10(40),1,1,-1,4);
arSetParsPattern('hill',log10(2),1,1,0,log10(7));
arSetPars('init_bsc1',2,1,1,0,4,1,1.5,0.5)
arSetPars('init_ubp1',0.2,1,1,-5,1)
arSetPars('init_foxa1',0.3,1,1,-0.5,1)
arSetPars('init_hes4',1.7,1,1,1.2,2.3)
arSetPars('init_hes5',0.8,1,1,0,1.6)
arSetPars('init_hes7',2.3,1,1,1.5,3)
arSetPars('init_ligand',1.3,1,1,0.8,1.8)
arSetPars('init_mcidas',0,1,1,-5,1)
arSetPars('init_multi_prog',-1,1,1,-5,4)
arSetPars('init_spdef',0,1,1,-1,0.5)
arSetPars('init_tp63',0,1,1,-1,0.5)
arSetParsPattern('km',1,1,1,0,3);
arSetPars('km_isc_on_fc',-1,1,1,-3,0);
arSetPars('km_hes4_on_fc',1,1,1,0,2);
arSetPars('km_hes4_off_fc',1,1,1,0,2); % relative to km_hes4_on
arSetPars('km_ssc_on_spdef_fc',1,1,1,0,2);
arSetPars('km_ssc_off_spdef_fc',1,1,1,0,2); % relative to km_ssc_on_spdef
arSetParsPattern('prod_ligand_rna',-2,1,1,-4,0)
arSetPars('prod_mcc_late',-1,1,1,-3,1);
arSetPars('prod_multi_prog',-1,1,1,-3,1);
arSetPars('prod_spdef_prot',-1,1,1,-4,2);
arSetPars('prod_sum_ligand_rna',-1,1,1,-4,2);
arSetParsPattern('reg_',0,1,1,-2,2,1,0,2) % Cell scale priors and production rate priors
arSetPars('scale_RNA',0,0,1,-2,2)
arSetPars('scale_isc',3,1,1,0,6)
arSetPars('scale_isc_pure',3,1,1,0,6)
arSetPars('scale_mcc',3,1,1,0,6)
arSetPars('scale_ssc',3,1,1,0,6)
arSetPars('scale_multi_prog_foxi1_fc',0,1,1,-3,3) % scale compared to scale_isc
arSetPars('sd_RNA',-1,1,1,-3,0)
arSetParsPattern('v_max',-1,1,1,-5,2)
arSetParsPattern('vmax',0,1,1,-2,2,1,0,0.3) % Fold changes for cell production rates
arSetParsPattern('prior_prod',1,0,1,0,2);
arSetPars('sd_cell',1,1,1,0,log10(50))
arSetParsPattern('scale_cell',0,1,1,-2,2,1,0,0.5);
arSetPars('scale_cell_mean',0,1,1,-3,3);

arSetParsPattern('init_isc',0,1,1,-3,3,1,0,2)
arSetParsPattern('init_mcc',0,1,1,-3,3,1,0,2)
arSetParsPattern('init_mpp',0,1,1,-3,3,1,0,2)
arSetPars('init_multi_prog',-2,1,1,-4,2,1,-4,3)
arSetPars('init_isc',-2,1,1,-4,2,1,-4,3)
arSetPars('init_mcc',-2,1,1,-4,2,1,-4,3)
arSetPars('init_hes4_gof_lc_fc',1,1,1,0,3);
arSetPars('init_hes5_gof_lc_fc',1,1,1,0,3);
arSetPars('init_hes7_gof_lc_fc',1,1,1,0,3);
arSetPars('transl_hes4_lof_fc',-1,1,1,-3,0);
arSetPars('transl_hes5_lof_fc',-1,1,1,-3,0);
arSetPars('transl_hes7_lof_fc',-1,1,1,-3,0);