%function [cellDist,dcellDist_dp] = calcCellDist(ps, cpr, trafo)
% This function calculates cell compositions for given parameters, wild
% type cell production rates and time transformation.
% 
%  ps      parameters
%  cpr     struct containing cell produciton rates
%  trafo   char specifying the parametrization of the time transformation
%

function [cellDist,dcellDist_dp] = calcCellDist(ps, cpr, trafo)
if(~exist('trafo','var') | isempty(trafo))
    trafo = [];
end

%% time transformation
if nargout==2
    [tFineTrafo, dtFineTrafo_dp] = timeTrafoSelector(trafo, ps, cpr);
    %timeTrafoJoined(cpr.tFine, ps(1,:), ps(2,:), tEnd);
else
    [tFineTrafo] = timeTrafoSelector(trafo, ps, cpr);
    %timeTrafoJoined(cpr.tFine, ps(1,:), ps(2,:), tEnd);
end

%{
tEnd = max(cpr.tFine);
if nargout==2
    [tFineTrafo, dtFineTrafo_dp] = timeTrafoJoined(cpr.tFine, ps(1,:), ps(2,:), tEnd);
else
    [tFineTrafo] = timeTrafoJoined(cpr.tFine, ps(1,:), ps(2,:), tEnd);
end
%}

prod = nan([size(tFineTrafo),size(cpr.vFineSimu,2)]);
dprod_dp = nan([size(tFineTrafo),size(cpr.vFineSimu,2), size(ps,1)]);
%% transformed production rate
for i = 1:size(cpr.vFineSimu,2)
    prod(:,:,i) = interp1(cpr.tFine,cpr.vFineSimu(:,i),tFineTrafo);
    if nargout==2
        dprod_dp(:,:,i,:) = derivative(cpr.tFine,cpr.vFineSimu(:,i),tFineTrafo).*dtFineTrafo_dp;
    end
end

%% numerical integral over time
%cellDist = trapz(cpr.tFine,cpr.vFineSimu);
cellDist = nan([size(cpr.vFineSimu,2),size(tFineTrafo,2)]);
if nargout==2
    dcellDist_dp = nan([size(cpr.vFineSimu,2),size(tFineTrafo,2),2]);
end
for i = 1:size(cpr.vFineSimu,2)
    cellDist(i,:) = sum( ...
        (cpr.tFine(2:end) - cpr.tFine(1:end-1)).* ...
        (prod(2:end,:,i) + prod(1:end-1,:,i)), ...
        1 ...
        )./2;
    if nargout==2
        for j = 1:size(dprod_dp,4)
            dcellDist_dp(i,:,j) = sum( ...
                (cpr.tFine(2:end) - cpr.tFine(1:end-1)).* ...
                (dprod_dp(2:end,:,i,j) + dprod_dp(1:end-1,:,i,j)), ...
                1 ...
                )./2;
        end
    end
end

end

