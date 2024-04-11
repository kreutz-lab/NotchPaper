% arNameTrafo(str)
%
% Transforms strings to avoid unintended behavior in plot labels
% due to latex interpreter
%
%    str        string, which is transformed

function str = arNameTrafo(str)


%-------------------------------------------------
%replacements added for Walentek project paper
%-------------------------------------------------
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
str = strrep(str, 'v_max_bsc2', 'p_bsc2');
str = strrep(str, 'v_max', 'p_cell');
str = strrep(str, 'ligand_', 'lig_');
str = strrep(str, 'hill_', 'h_');
str = strrep(str, 'prod_', 'p_');
str = strrep(str, 'deg_', 'd_');
str = strrep(str, 'km_', 'k_');
str = strrep(str, '_on', '_a');
str = strrep(str, '_off', '_i');
%% derived
str = strrep(str, 'nicd_signal', '');
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
%-------------------------------------------------

str = strrep(str, '_', '\_');
str = strrep(str, '%', '\%');