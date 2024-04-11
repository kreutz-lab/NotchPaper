%function [tFineTrafo, dtFineTrafo_dp] = timeTrafoSelector(trafo, ps, cpr)
%TIMETRAFOSELECTOR Summary of this function goes here
%   Detailed explanation goes here
%

function [tFineTrafo, dtFineTrafo_dp] = timeTrafoSelector(trafo, ps, cpr)
if(~exist('trafo','var') | isempty(trafo))
    trafo = 'logistic';
end

tEnd = max(cpr.tFine);
switch trafo
    case 'logistic'
        if nargout==2
            [tFineTrafo, dtFineTrafo_dp] = timeTrafoJoined(cpr.tFine, ps(1,:), ps(2,:), tEnd);
        else
            [tFineTrafo] = timeTrafoJoined(cpr.tFine, ps(1,:), ps(2,:), tEnd);
        end
    case 'free_end'
        if nargout==2
            [tFineTrafo, dtFineTrafo_dp] = timeTrafoJoinedFreeEnd(cpr.tFine, ps(1,:), ps(2,:), ps(3,:));
        else
            [tFineTrafo] = timeTrafoJoinedFreeEnd(cpr.tFine, ps(1,:), ps(2,:), ps(3,:));
        end
    case 'linear'
        if nargout==2
            [tFineTrafo, dtFineTrafo_dp] = timeTrafoJoinedLinear(cpr.tFine, ps(1,:), tEnd);
        else
            [tFineTrafo] = timeTrafoJoinedLinear(cpr.tFine, ps(1,:), tEnd);
        end
    case 'identity'
        [tFineTrafo] = cpr.tFine;
    otherwise
        error('Unknown trafo identifier!')
end

end

