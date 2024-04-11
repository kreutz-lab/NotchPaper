%function [pSample,grids,meritGrid] = findTrafoSample(...
%    targetCond, ...
%    distanceMetric, ...
%    timeTrafo, ...
%    lb, ...
%    ub, ...
%    pathToArStruct, ...
%    result, ...
%    nGrid, ...
%    cond ...
%    )
%
%

function [pSample,grids,meritGrid] = findTrafoSample(...
    targetCond, ...
    distanceMetric, ...
    timeTrafo, ...
    lb, ...
    ub, ...
    pathToArStruct, ...
    result, ...
    nGrid, ...
    cond ...
    )
if ~exist('targetCond','var') || isempty(targetCond)
    targetCond = [];
end
if ~exist('distanceMetric','var') || isempty(distanceMetric)
    distanceMetric = 'bc';
end
if ~exist('pathToArStruct','var') || isempty(pathToArStruct)
    pathToArStruct = [];
end
if ~exist('result','var') || isempty(result)
    result = [];
end
if ~exist('timeTrafo','var') || isempty(timeTrafo)
    timeTrafo = 'logistic';
end
smoothMax = 0.02;
if ~exist('lb','var') || isempty(lb)
    lb = [0,-smoothMax,0.00001];
end
if ~exist('ub','var') || isempty(ub)
    ub = [nan,smoothMax,100];
end
if strcmp(timeTrafo,'logistic') && numel(lb)==3
    lb(3) = [];
    ub(3) = [];
end
if ~exist('nGrid','var') || isempty(nGrid)
    if numel(lb)==3
        nGrid = 100;
    else
        nGrid = 500;
    end
end
if ~exist('cond','var') || isempty(cond)
    cond = 1;
end

cpr = getCellProdRates(pathToArStruct,result,cond);
	% Read out WT cell productions from the model
tEnd = max(cpr.tFine);
if isnan(ub(1))
    ub(1) = tEnd;
end

[targetDist,targetSigma] = getTargetDist(targetCond);
	% Get experimental data for the cell type composition in the specific condition

% meritFunctionFactory defines a function, which generates a merit function 
% value which measures the overlap of measured cell type composition and
% cell tape composition from the time transformation
meritFunction = meritFunctionFactory(cpr, targetDist, distanceMetric, targetSigma, timeTrafo);
	% This returns a function which only takes the time-transformation 
	% parameters as input

[pairs, grids] = getParGrid(lb,ub,nGrid);

% Apply merit function for all parameter combinations on the grid:
nSingle = 100000;
merit = nan([size(pairs,2),1]);
for i = 1:ceil(size(pairs,2)/nSingle)
    if i==ceil(size(pairs,2)/nSingle)
        merit((i-1)*nSingle+1:end) = meritFunction(pairs(:,(i-1)*nSingle+1:end));
    else
        idx = ((i-1)*nSingle+1):(i*nSingle);
        merit(idx) = meritFunction(pairs(:,idx));
    end
end
meritGrid = reshape(merit',repmat(nGrid,[1,numel(lb)]));
[~,idxMin] = min(merit);
pSample = pairs(:,idxMin);

end