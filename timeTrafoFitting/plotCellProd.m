%function [] = plotCellProd(trafoAna,fitOrSample,doPrint)
%PLOTCELLPROD Summary of this function goes here
%   Detailed explanation goes here
%
%

function [] = plotCellProd(trafoAna,fitOrSample,doPrint)
if ~exist('fitOrSample','var') || isempty(fitOrSample)
    fitOrSample = 'sample';
end
if ~exist('doPrint','var') || isempty(doPrint)
    doPrint = false;
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

timeTrafo = trafoAna.info.timeTrafo;
cpr = getCellProdRates(...
    trafoAna.info.pathToArStruct,...
    trafoAna.info.result,...
    trafoAna.info.cond...
    );

fNames = [setdiff(fieldnames(trafoAna),{'info'});{'wt'}];
fNames = getCondOrder(fNames);

yMax = 1.1*max(cpr.vFineSimu,[],'all');
%tEndProd = max(cpr.tFine);
%tEndProd = 1.1*max(cpr.tFine);
tEndProd = trafoAna.gof.grids(1,end,1);
cp = [];
for i = 1:length(fNames)
    subplot(length(fNames),1,i)
    if strcmp(fNames{i},'wt')
        tFineTrafo = timeTrafoSelector('identity', trafoAna.('lof').(fitOrSample), cpr);
    else
        tFineTrafo = timeTrafoSelector(timeTrafo, trafoAna.(fNames{i}).(fitOrSample), cpr);
    end
    for j = 1:size(cpr.vFineSimu,2)
        %cp = [cp, plot(tFineTrafo,cpr.vFineSimu(:,j),'Color',cols(j,:),'LineWidth',2)];
        cp = [cp, plot(cpr.tFine,interp1(cpr.tFine,cpr.vFineSimu(:,j),tFineTrafo),'LineWidth',2)];
        cp(end).Color(4)=0.7;
        hold on
    end
    xlim([0,tEndProd])
    ylim([0,yMax]);
    title(strrep(fNames{i},'_','\_'))
    if i==(length(fNames)-1)
        %ylabel('production rate [1/(min$\cdot$reference-area)]','Interpreter','latex')
        ylabel('production rate [1/(min reference-area)]')
    end
    if i==length(fNames)
        legend({'ISC','MCC','SSC'},'Location','northeast')
        %xlabel('original time [min]','Interpreter','latex')
        xlabel('original time [min]')
    end
end

if doPrint
    %print(['plotCellProd_' trafoAna.info.timeTrafo '_' trafoAna.info.distanceMetric],'-dpng','-r300')
    [~,folder] = fileparts(trafoAna.info.pathToArStruct);
    result = trafoAna.info.result;
    if ~isfolder(['..' filesep 'paper' filesep 'paperFigures__' folder])
        mkdir(['..' filesep 'paper' filesep 'paperFigures__' folder])
    end
    filename = ['..' filesep 'paper' filesep 'paperFigures__' folder filesep 'plotCellProd__' trafoAna.info.distanceMetric '__' trafoAna.info.timeTrafo];
    printPdf(fig,filename);
end

end

