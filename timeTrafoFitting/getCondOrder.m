%function [fNames] = getCondOrder()
%GETCONDORDER Summary of this function goes here
%   Detailed explanation goes here

function [fNames] = getCondOrder(fNamesOld)

fNames = {'wt','lof','gof_low','gof','gof_mean'};
[~,idx] = intersect(fNames,fNamesOld,'stable');
fNames = fNames(idx);

end

