%function [] = plotCellCo(trafoAna,normalized,fitOrSample,doPrint)
%PLOTCELLCO Summary of this function goes here
%   Detailed explanation goes here
%
%

function [] = plotCellCo(trafoAna,fitOrSample,doPrint)
if ~exist('fitOrSample','var') || isempty(fitOrSample)
    fitOrSample = 'sample';
end
if ~exist('doPrint','var') || isempty(doPrint)
    doPrint = false;
end

if strcmp(trafoAna.info.distanceMetric,'chi2')
    normalized = 0;
elseif strcmp(trafoAna.info.distanceMetric,'bc')
    normalized = 1;
end

switch fitOrSample
    case 'fit'
        fitOrSample = 'pFit';
    case 'sample'
        fitOrSample = 'pSample';
    otherwise
        error('unknown parameter source selected')
end


fig = figure;

cpr = getCellProdRates(...
    trafoAna.info.pathToArStruct,...
    trafoAna.info.result,...
    trafoAna.info.cond...
    );

fNames = [setdiff(fieldnames(trafoAna),{'info'});{'wt'}];
fNames = getCondOrder(fNames);
ccs = [];
xLabel = {};
X = [];
for i = 1:length(fNames)
    X = [X,3*i,3*i+1];
    if strcmp(fNames{i},'wt')
        ccs = [ccs, calcCellDist(trafoAna.('lof').(fitOrSample),cpr,'identity')];%lof chosen randomly, identity is parameter independent
        xLabel = [xLabel, {[fNames{i} '_model']}];
        ccs = [ccs, getTargetDist(fNames{i})];
        xLabel = [xLabel, {[fNames{i} '_data']}];
    else
        ccs = [ccs, calcCellDist(trafoAna.(fNames{i}).(fitOrSample),cpr,trafoAna.info.timeTrafo)];
        xLabel = [xLabel, {[fNames{i} '_model']}];
        ccs = [ccs, getTargetDist(fNames{i})];
        xLabel = [xLabel, {[fNames{i} '_data']}];
    end
end

if normalized
    ccs = 100.*ccs./sum(ccs,1);
    yLab = 'percentage of cells';
else
    yLab = 'number of cells';
end

xLabel = strrep(xLabel,'_','\_');
b = bar(X,ccs','stacked');

legend(b,{'ISC','MCC','SSC'},'Location','northeast')
ylabel(yLab);
ylim([0 100]);

set(gca,'XTickLabel',xLabel');
set(gca,'XTickLabelRotation',30);

if doPrint
    %print(['plotCellCo_' trafoAna.info.timeTrafo '_' trafoAna.info.distanceMetric],'-dpng','-r300')
    [~,folder] = fileparts(trafoAna.info.pathToArStruct);
    result = trafoAna.info.result;
    if ~isfolder(['..' filesep 'paper' filesep 'paperFigures__' folder])
        mkdir(['..' filesep 'paper' filesep 'paperFigures__' folder])
    end
    filename = ['..' filesep 'paper' filesep 'paperFigures__' folder filesep 'plotCellCo__' trafoAna.info.distanceMetric '__' trafoAna.info.timeTrafo];
    printPdf(fig,filename);
end

end

