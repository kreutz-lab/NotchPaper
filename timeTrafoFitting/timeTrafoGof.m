%function [tNew, dtNew_dp] = timeTrafoGof(t_old,t_offset,smoothness,tEnd)
%
%

function [tNew, dtNew_dp] = timeTrafoGof(t,tOffset,smoothness,tEnd)

if nargout==2
    [factor, dfactor_dp] = timeTrafoLogistic(tEnd,tOffset,smoothness,1);
    [tNew, dtNew_dp_partial] = timeTrafoLogisticInv(t,tOffset,smoothness,tEnd./factor);
else
    [tNew] = timeTrafoLogisticInv(t,tOffset,smoothness,tEnd./timeTrafoLogistic(tEnd,tOffset,smoothness,1));
end

if nargout==2
    dtNew_dp = nan([size(tNew),2]);
    dtNew_dp(:,:,1) = dtNew_dp_partial(:,:,1) - dtNew_dp_partial(:,:,3).*tEnd.*dfactor_dp(:,:,1)./factor.^2;
    dtNew_dp(:,:,2) = dtNew_dp_partial(:,:,2) - dtNew_dp_partial(:,:,3).*tEnd.*dfactor_dp(:,:,2)./factor.^2;
end

tNew(isinf(tNew) | isnan(tNew)) = 0;
dtNew_dp_partial(isinf(tNew) | isnan(tNew)) = 0;

end
