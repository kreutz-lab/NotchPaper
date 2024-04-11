%function [] = plotTimeTrafo(trafoAna,fitOrSample,doPrint)
%PLOTTIMETRAFO Summary of this function goes here
%   Detailed explanation goes here
%
%

function [] = plotTimeTrafo(trafoAna,fitOrSample,doPrint)
if ~exist('fitOrSample','var') || isempty(fitOrSample)
    fitOrSample = 'sample';
end
if ~exist('doPrint','var') || isempty(doPrint)
    doPrint = false;
end

fig = figure;
timeTrafo = trafoAna.info.timeTrafo;
fNames = setdiff(fieldnames(trafoAna),{'info'});
cpr = getCellProdRates(...
    trafoAna.info.pathToArStruct,...
    trafoAna.info.result,...
    trafoAna.info.cond...
    );

cols = get(gca,'ColorOrder');

leg = {};
pl = [];
for i = 1:length(fNames)
    if any(strcmp(fitOrSample,{'all','fit'}))
        pl = [pl, plot(cpr.tFine,timeTrafoSelector(timeTrafo, trafoAna.(fNames{i}).pFit, cpr),'--','Color',cols(i,:),'LineWidth',2)];
        leg = [leg, {[fNames{i} '_fitted']}];
    end
    hold on
    if any(strcmp(fitOrSample,{'all','sample'}))
        pl = [pl, plot(cpr.tFine,timeTrafoSelector(timeTrafo, trafoAna.(fNames{i}).pSample, cpr),'-','Color',cols(i,:),'LineWidth',1.5)];
        %leg = [leg, {[fNames{i} '_sampled']}];
        leg = [leg, {fNames{i}}];
    end
end
pl = [pl, plot(cpr.tFine,cpr.tFine,'--','Color','black','LineWidth',1)];
leg = [leg, {'identity'}];

legend(pl, strrep(leg,'_','\_'),'location','southeast')
xlabel('original time [min]')
ylabel('transformed time [min]')
%tMax = max(cpr.tFine);
tMax = trafoAna.gof.grids(1,end,1);
xlim([0 tMax])
ylim([0 tMax])

if doPrint
    %print(['plotTimeTrafo_' trafoAna.info.timeTrafo '_' trafoAna.info.distanceMetric],'-dpng','-r300')
    [~,folder] = fileparts(trafoAna.info.pathToArStruct);
    result = trafoAna.info.result;
    if ~isfolder(['..' filesep 'paper' filesep 'paperFigures__' folder])
        mkdir(['..' filesep 'paper' filesep 'paperFigures__' folder])
    end
    filename = ['..' filesep 'paper' filesep 'paperFigures__' folder filesep 'plotTimeTrafo__' trafoAna.info.distanceMetric '__' trafoAna.info.timeTrafo];
    printPdf(fig,filename);
end

end

