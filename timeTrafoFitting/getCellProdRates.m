%function [cellProdRates] = getCellProdRates(pathToArStruct,result,cond)
% This function fetches the cell production rates from an ar struct in
% which the WT/control is modeled in condition cond.
%

function [cellProdRates] = getCellProdRates(pathToArStruct,result,cond)
if ~exist('pathToArStruct','var') || isempty(pathToArStruct)
    %pathToArStruct = 'C:\Users\florenz\Projekte\Walentek\notchmcc\d2d_projects\20221014_early_prog_simple_notchInhibHes4_logScale';
    %pathToArStruct = 'C:\Users\florenz\Projekte\Walentek\notchmcc\d2d_projects\20221130_spdef__spdef_on_foxa1';
    error('path to d2d project folder must be given')
end
if ~exist('result','var') || isempty(result)
    %result = '20221021T170608_lhs';
    %result = '20221203T121618_ple';
    error('name of d2d results folder must be given')
end
if ~exist('cond','var') || isempty(cond)
    cond = 1;
end

condStr = num2str(cond);
if isfile(['cpr__cond' condStr '__' result '.mat'])
    tmp = load(['cpr__cond' condStr '__' result '.mat']);
    cellProdRates = tmp.cellProdRates;
end

origDir = cd(pathToArStruct);
global ar
arLoad(result)
arSimu(0,1);
cd(origDir);

fluxNames = {'Differentiation into ISC', 'Differentiation into MCC', 'Differentiation into SSC'};

cellProdRates = struct;
cellProdRates.fluxLabels = fluxNames;
cellProdRates.tFine = ar.model.condition(cond).tFine;
cellProdRates.vFineSimu = nan([size(ar.model.condition(cond).tFine,1), length(fluxNames)]);

for i = 1:length(fluxNames)
    idx = strcmp(ar.model.v, fluxNames{i});
    cellProdRates.vFineSimu(:,i) = ar.model.condition(cond).vFineSimu(:,idx);
end

if ~isempty(arFindPar('scale_cell_abs'))
    cellProdRates.vFineSimu = cellProdRates.vFineSimu .* arGetPars('scale_cell_abs',0);
end

cellProdRates.tFine = cellProdRates.tFine(cellProdRates.tFine>=0);%cut negative times
cellProdRates.vFineSimu = cellProdRates.vFineSimu(cellProdRates.tFine>=0,:);

[~,folder] = fileparts(pathToArStruct);
save(['cpr__cond' condStr '__' folder '__' result '.mat'], 'cellProdRates');

end

