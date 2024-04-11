% This script generates the time transformation to describe the 
% cell type production rate of the Notch GoF/LoF condition by a 
% time-transformation from the cell type production rate in the WT condition.
% 
% The optimal time-transformation is determined by comparing cell-type composition
% in the Notch GoF/LoF as measured in the experiments compared with the implied
% cell type composition by the time transformed cell type production rates.

%targetCondList = {'lof','gof','gof_low','gof_mean'};
targetCondList = {'lof','gof'};

%distanceMetric = 'chi2';
distanceMetric = 'bc'; %Bray-Curtis dissimilarity

pathToArStruct = 'C:\Users\litwin\Documents\MATLAB\NotchPaper'; 
	% Put the corresponding d2d directory in this path
% result = '20221215T175813_ple'; 
    % Fabians model result without spdef
result = '20240325T112126_withspdef'; 
    % Fabians model result with spdef
% result = '20240325T171819_HesGoFLoF_mppconversion_cellprod';
    % Tims model result with Hes perturbations

smoothMax = 0.04;

timeTrafo = 'logistic';
if strcmp(result,'20240325T171819_HesGoFLoF_mppconversion_cellprod')
	% Time scale in Model 2.1 is adjusted for numerical stability, new time = old time/10
    lb_lof = [0   ,         0];
    ub_lof = [136, smoothMax];
    lb_gof = [100   ,-smoothMax];
    ub_gof = [136,         0];
else
    lb_lof = [0   ,         0];
    ub_lof = [1364, smoothMax];
    lb_gof = [0   ,-smoothMax];
    ub_gof = [1364,         0];
end
lbs = [lb_lof;lb_gof;lb_gof;lb_gof];
ubs = [ub_lof;ub_gof;ub_gof;ub_gof];
% Both parameter values implied here are arguments for the time-transformation
% The optimal parameter values are determined in this algorithm
cond = 1;

trafoAna = struct();
trafoAna.info.timeTrafo = timeTrafo;
trafoAna.info.distanceMetric = distanceMetric;
trafoAna.info.pathToArStruct = pathToArStruct;
trafoAna.info.result = result;
trafoAna.info.cond = cond;

% Now comes the main function of the algorithm. This function samples the
% parameter space given by the bounds earlier on a grid, calculates the
% time-transformation for each one and evaluates the distance between data
% cell-composition and model implied cell-composition and stores the 
% information in trafoAna
for i = 1:length(targetCondList)
    [pSample,grids,meritGrid] = findTrafoSample(...
        targetCondList{i}, ...
        distanceMetric, ...
        timeTrafo, ...
        lbs(i,:), ...%lb, ...
        ubs(i,:), ...%ub, ...
        pathToArStruct, ...
        result, ...
        [], ...%nGrid, ...
        [] ...%cond ...
        );
    trafoAna.(targetCondList{i}).pSample = pSample;
    trafoAna.(targetCondList{i}).grids = grids;
    trafoAna.(targetCondList{i}).meritGrid = meritGrid;
end

% The functions below plots results from trafoAna 

meritLandscape(trafoAna);

plotTimeTrafo(trafoAna);

plotCellCo(trafoAna);

plotCellProd(trafoAna);

[~,folder] = fileparts(pathToArStruct);
save(['timeTrafoAna__' trafoAna.info.distanceMetric '__' trafoAna.info.timeTrafo  '__' folder '__' result '.mat'], 'trafoAna');
