%function [pairs, grids] = getParGrid(lb,ub,nGrid)
%
%
%

function [pairs, grids] = getParGrid(lb,ub,nGrid)
if ~exist('nGrid','var') || isempty(nGrid)
    nGrid = 50;
end

psAll = cell(size(lb,2),1);
for i = 1:size(lb,2)
     psAll{i} = linspace(lb(i),ub(i),nGrid);
end
if size(lb,2) == 2
    [grid1, grid2] = meshgrid(psAll{:});
    pairs = [grid1(:), grid2(:)]';
    grids = reshape([grid1,grid2],[size(grid1),2]);
elseif size(lb,2) == 3
    [grid1, grid2, grid3] = meshgrid(psAll{:});
    pairs = [grid1(:), grid2(:), grid3(:)]';
    grids = reshape([grid1,grid2,grid3],[size(grid1),3]);
else 
    error('Too many parameters for sampling!')
end

end

