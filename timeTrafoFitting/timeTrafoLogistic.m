%function [tNew, dtNew_dp] = timeTrafoLogistic(t,tOffset,smoothness,scale)
%

function [tNew, dtNew_dp] = timeTrafoLogistic(t,tOffset,smoothness,scale)

tNew = ...
    scale./smoothness.*(...
    log(exp(smoothness.*(t-tOffset))+1) - ...
    log(exp(-smoothness.*tOffset)+1)...
    );

if nargout==2
    dtNew_dp = nan([size(tNew),3]);
    dtNew_dp(:,:,1) = -(scale.*(exp(smoothness.*t) - 1))./ ...
        ((exp(smoothness.*tOffset) + 1).*(exp(smoothness.*(t - tOffset)) + 1));
    dtNew_dp(:,:,2) = (scale.*(log(exp(-smoothness.*tOffset) + 1) - log(exp(smoothness.*(t - tOffset)) + 1)))./smoothness.^2 + ...
        (scale.*(tOffset./(exp(smoothness.*tOffset) + 1) + (exp(smoothness.*(t - tOffset)).*(t - tOffset))./(exp(smoothness.*(t - tOffset)) + 1)))./smoothness;
    dtNew_dp(:,:,3) = -(log(exp(-smoothness.*tOffset) + 1) - log(exp(smoothness.*(t - tOffset)) + 1))./smoothness;
end

end



