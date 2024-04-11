global ar
arLoad('20221215T174237_ple')

%% names for model and data
modelName = 'Include spdef';% name of the model
rnaSeqDataName = 'RNAseq data';% name for RNAseq data set
cellQuantDataName = 'Cell quantification data';% name for cell quatification data set
priorDataName = 'Priors';% name for data points representing priors
%% description of model and data (displayed under "Comments" in the model/data chapter)
modelComment = {'Model for the cell composition in mucociliary tissue.'};
rnaSeqComment = {'Time-resolved RNAseq data for the most important molecular players in the mdoelled mucociliary tissue.'};
cellQuantComment = {'Cell counts for the specified cell types from immunoflourescence images.'};
priorComment = {'A prior data point is introduced ensuring that finally the multipotent progenitors have to decide for one cell fate.'};


ar.pLabel = repl(ar.pLabel);
%% make string replacements
for jm = 1:length(ar.model)
    ar.model(jm).p = repl(ar.model(jm).p);
    if isfield(ar.ple,'p_labels')
        ar.ple.p_labels = repl(ar.ple.p_labels);
    end
    
    %% replacements via repl function
    ar.model(jm).x = repl(ar.model(jm).x);
    ar.model(jm).fx = repl(ar.model(jm).fx);
    ar.model(jm).v = repl(ar.model(jm).v);
    ar.model(jm).fv = repl(ar.model(jm).fv);
    %ar.model(jm).u = repl(ar.model(jm).u);% no input in this case
    %ar.model(jm).fu = repl(ar.model(jm).fu);
    ar.model(jm).z = repl(ar.model(jm).z);
    ar.model(jm).fz = repl(ar.model(jm).fz);
    ar.model(jm).px0 = repl(ar.model(jm).px0);
    ar.model(jm).fp = repl(ar.model(jm).fp);
    
    %% name/descriptions of model and data
    ar.model(jm).name = modelName;
    ar.model(jm).description = modelComment;
    ar.model(jm).data(1).name = rnaSeqDataName;
    ar.model(jm).data(1).description = rnaSeqComment;
    ar.model(jm).data(2).name = cellQuantDataName;
    ar.model(jm).data(2).description = cellQuantComment;
    ar.model(jm).data(3).name = priorDataName;
    ar.model(jm).data(3).description = priorComment;
    
    %% observable renaming
    ar.model(jm).data(1).y = repl(ar.model(jm).data(1).y);
    
    %% plot y labels
    ar.model(jm).data(1).yUnits(:,2) = {'tpm'};
    ar.model(jm).data(1).yUnits(:,3) = {''};
    ar.model(jm).data(2).yUnits(:,2) = {''};
    ar.model(jm).data(2).yUnits(:,3) = {'number of cells'};
    
    for jd = 1:length(ar.model(jm).data)
        ar.model(jm).data(jd).fy = repl(ar.model(jm).data(jd).fy);
        ar.model(jm).data(jd).fp = repl(ar.model(jm).data(jd).fp);
        ar.model(jm).data(jd).pold = repl(ar.model(jm).data(jd).pold);
        ar.model(jm).data(jd).py = repl(ar.model(jm).data(jd).py);
        ar.model(jm).data(jd).pystd = repl(ar.model(jm).data(jd).pystd);
        for ii = 1:length(ar.model(jm).data(jd).py_sep)
            ar.model(jm).data(jd).py_sep(ii).pars = repl(ar.model(jm).data(jd).py_sep(ii).pars);
        end
        ar.model.data(jd).condition = [];
    end
    
    for jc = 1:length(ar.model(jm).condition)
        ar.model(jm).condition(jc).fp = repl(ar.model(jm).condition(jc).fp);
        ar.model(jm).condition(jc).p = repl(ar.model(jm).condition(jc).p);
        ar.model(jm).condition(jc).pold = repl(ar.model(jm).condition(jc).pold);
        ar.model(jm).condition(jc).px0 = repl(ar.model(jm).condition(jc).px0);
    end
    
end

save('Results/arStructForReport/workspace.mat','ar')
%{
arPlot(1)
plePlotMulti([],1)
curPath = cd(['Figures' filesep 'Y_ploterrors0_fiterrors0']);
D = dir('*.pdf');
pdfs = {D.name};
for dd = 1:length(pdfs)
    system(['pdfcrop ' pdfs{dd} '.pdf ' pdfs{dd} '.pdf']);
end
cd(curPath);
%}

function str = repl(str)
str = strrep(str, 'scale_cell_abs', 'FOLDRAUS');
str = strrep(str, 'prolif_multi_prog', 'NULLRAUS');
str = strrep(str, 'background_foxi1', 'NULLRAUS');
str = strrep(str, 'km_hes7_off_fc', 'FOLDRAUS');
str = strrep(str, 'init_ligand_rna_fc', 'FOLDRAUS');
str = strrep(str, 'init_hes7_rna_fc', 'FOLDRAUS');
str = strrep(str, 'notch_lof_fc', 'FOLDRAUS');
str = strrep(str, 'notch_gof_fc', 'FOLDRAUS');
str = strrep(str, 'init_hes4_gof_fc', 'FOLDRAUS');
str = strrep(str, 'init_hes5_gof_fc', 'FOLDRAUS');
str = strrep(str, 'init_hes7_gof_fc', 'FOLDRAUS');
str = strrep(str, 'init_tp63_gof_fc', 'FOLDRAUS');
str = strrep(str, 'init_spdef_gof_fc', 'FOLDRAUS');
str = strrep(str, 'nicd_signal', 'RAUS');

%NOTE: order of replacements matter!!!
%% delay states
str = strrep(str, 'rna_del', 'rna_d');
%% cell types
str = strrep(str, 'multi_prog', 'mpp');
str = strrep(str, 'bsc1', 'ep');
str = strrep(str, 'bsc2', 'bc');
%% effective/protein capitalized
str = strrep(str, 'hes4_rna_del', 'Hes4');
str = strrep(str, 'hes5_rna_del', 'Hes5');
str = strrep(str, 'hes7_rna_del', 'Hes7');
str = strrep(str, 'spdef_prot', 'Spdef');
str = strrep(str, 'sum_ligand_rna', 'Lig');
%% rna lower case
str = strrep(str, 'hes4_rna', 'hes4');
str = strrep(str, 'hes5_rna', 'hes5');
str = strrep(str, 'hes7_rna', 'hes7');
str = strrep(str, 'tp63_rna', 'tp63');
str = strrep(str, 'spdef_rna', 'spdef');
str = strrep(str, 'ligand_rna', 'lig');
%% further abbreviations
str = strrep(str, 'scale_', 's_');
%str = strrep(str, 'v_max_bsc2', 'p_bsc2');
%str = strrep(str, 'v_max', 'p_cell');
str = strrep(str, 'ligand_', 'lig_');
str = strrep(str, 'hill_', 'h_');
str = strrep(str, 'prod_', 'p_');
str = strrep(str, 'deg_', 'd_');
str = strrep(str, 'km_', 'k_');
str = strrep(str, '_on', '_a');
str = strrep(str, '_off', '_i');
%% observabels
str = strrep(str, 'ligands_tot', 'lig');
if contains(str,'sd_tpm_')
    str = strrep(str, 'sd_tpm_', 'sd_');
    str = append(str,'_tpm');
end
if(any(contains(str,'ligands_tot')))
    str = strrep(str, 'ligands_tot', 'lig');
    str = append(str,'_tpm');
end
str = strrep(str, 'forget_ligands', 'd_Lig');


end