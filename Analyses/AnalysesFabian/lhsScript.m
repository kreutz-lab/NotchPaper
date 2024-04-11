try
    addpath('~/d2d/arFramework3')
    addpath('../../lib')
end

arInit
ar.config.checkForNegFluxes = 0;    
arLoadModel('spdef__spdef_on_foxa1__notchOnTp63.def')
arLoadData('RNAseq_data_WT_controls_correctedTimes');% 1
%arLoadData('RNAseq_data_NotchGOF_correctedTimes');% 1
%arLoadData('RNAseq_data_NotchLOF_correctedTimes');% 1
arLoadData('cellQuant_data_ctrl_absNums');    % 4
%arLoadData('cellQuant_data_GOF_low_absNums');    % 4
%arLoadData('cellQuant_data_LOF_absNums');    % 4
arLoadData('cell_prior');             % 7
arCompileAll();
arSetParsPattern('hill_',log10(2),1,1,0,1);

setPars
arLoadPars('20221215T140647_notchOnTp63');

%arSetPars('init_hes4_gof_fc',0.15,1,1,0.1,0.2);
%arSetPars('init_hes5_gof_fc',0.52,1,1,0.47,0.57);
%arSetPars('init_hes7_gof_fc',-0.2,1,1,-0.7,0.01);
%arSetPars('init_tp63_gof_fc',0.69,1,1,0.23,0.9);
%arSetPars('notch_gof_fc',0,1,1,0,2);
%arSetPars('notch_lof_fc',0,1,1,-5,0);

%arSetPars('prod_multi_prog',-2.5,1,1,-5,-1);
%arSetPars('prolif_multi_prog',0,1,0,0,1);
%arSetPars('km_mcc_off_hes5_delta',0,1,1,-5,3);
%arSetPars('km_ssc_off_hes4_delta',0,1,1,-5,3);

%{
for i = 1:length(ar.model.data)
    if all(i~=[1,4,7])
        ar.model.data(i).qFit(:) = 0;
        ar.model.qPlotYs(i) = 0;
    end
end
ar.qFit([arFindPar('gof'),arFindPar('lof')]) = 0;
ar.config.sensitivitySubset = 1;
%}

%ar.config.optim.Display = 'iter';
ar.model.data(3).qFit(2) = 0;
ar.config.optim.Display = 'off';
ar.config.optim.TolX = 10^-4;
%arSetPars('prod_ligand_rna_multi_prog_factor',0,0,1,-1,1);
%arSave('end_prolif_ple')
arSave('lhs')

arFit
arSave('current')

arFitLHSMulti(5,1000)
