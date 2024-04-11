%function [targetDist,targetSigma] = getTargetDist(targetCond)
%GETTARGETDIST Summary of this function goes here
%   Detailed explanation goes here

function [targetDist,targetSigma] = getTargetDist(targetCond)
if ~exist('targetCond','var') || isempty(targetCond)
    targetCond = 'lof';
end

switch targetCond
    case 'lof'
        file = 'cellQuant_data_LOF_absNums.xlsx';
    case 'gof'
        file = 'cellQuant_data_GOF_high_absNums.xlsx';
    case 'gof_low'
        file = 'cellQuant_data_GOF_low_absNums.xlsx';
    case 'gof_mean'
        file = 'cellQuant_data_GOF_high_absNums.xlsx';
        file2 = 'cellQuant_data_GOF_low_absNums.xlsx';
    case 'wt'
        file = 'cellQuant_data_ctrl_absNums.xlsx';
    otherwise
        error('unknown condtition selected!')
end

tab = readtable(file);
targetDist = [tab.isc_abs; tab.mcc_abs; tab.ssc_abs];
targetSigma = [tab.isc_abs_std; tab.mcc_abs_std; tab.ssc_abs_std];

if exist('file2','var') && ~isempty(file2)
    tab2 = readtable(file2);
    targetDist2 = [tab2.isc_abs; tab2.mcc_abs; tab2.ssc_abs];
    targetSigma2 = [tab2.isc_abs_std; tab2.mcc_abs_std; tab2.ssc_abs_std];
    targetDist = (targetDist + targetDist2)./2;
    targetSigma = (targetSigma.^2 + targetSigma2.^2)./2;
end

end

