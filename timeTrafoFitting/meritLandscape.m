%function [] = meritLandscape(trafoAna)
%MERITLANDSCAPE Summary of this function goes here
%   Detailed explanation goes here
%


function [] = meritLandscape(trafoAna)
if strcmp(trafoAna.info.timeTrafo,'free_end')
    warning('more than two parameters: landscape cannot be plotted')
    return
end
fNames = setdiff(fieldnames(trafoAna),{'info'});
fNames = getCondOrder(fNames);

figure;
for i = 1:length(fNames)
    subplot(1,length(fNames),i);
    mesh(trafoAna.(fNames{i}).grids(:,:,1), trafoAna.(fNames{i}).grids(:,:,2), trafoAna.(fNames{i}).meritGrid)
    hold on
    %fitted parameter
    if isfield(trafoAna.(fNames{i}),'pFit')
        p = num2cell(trafoAna.(fNames{i}).pFit);
        scatter3(...
            p{:},...
            trafoAna.(fNames{i}).fval,...
            'o',...
            'MarkerFaceColor','red'...
            )
    end
    %x = num2cell(trafoAna.(fNames{i}).history.x',[1,size(trafoAna.(fNames{i}).history.x,2)]);
    %scatter3(...
    %    x{:},...
    %    trafoAna.(fNames{i}).history.fval',...
    %    'o',...
    %    'MarkerFaceColor','black'...
    %    )
    title(fNames{i})
end

end

