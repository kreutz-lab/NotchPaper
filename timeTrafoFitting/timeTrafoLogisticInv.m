%function [tNew, dtNew_dp] = timeTrafoLogisticInv(t,tOffset,smoothness,scale)
%

function [tNew, dtNew_dp] = timeTrafoLogisticInv(t,tOffset,smoothness,scale)

tNew = tOffset + ...
    1./smoothness .* log(exp(smoothness.*t./scale+log(exp(-smoothness.*tOffset)+1))-1);

%tNewApprox = tOffset + ...
%    (log(exp(-smoothness.*tOffset)))./smoothness + t./scale.*(exp(smoothness.*tOffset) + 1) - 1/2.*t./scale.^2.*(smoothness.*exp(smoothness.*tOffset).*(exp(smoothness.*tOffset) + 1)) + 1/6.*smoothness.^2.*t./scale.^3.*exp(smoothness.*tOffset).*(3.*exp(smoothness.*tOffset) + 2.*exp(2.*smoothness.*tOffset) + 1) - 1/24.*t./scale.^4.*(smoothness.^3.*exp(smoothness.*tOffset).*(7.*exp(smoothness.*tOffset) + 12.*exp(2.*smoothness.*tOffset) + 6.*exp(3.*smoothness.*tOffset) + 1)) + 1/120.*smoothness.^4.*t./scale.^5.*exp(smoothness.*tOffset).*(15.*exp(smoothness.*tOffset) + 50.*exp(2.*smoothness.*tOffset) + 60.*exp(3.*smoothness.*tOffset) + 24.*exp(4.*smoothness.*tOffset) + 1);

%idxInf = isinf(tNew);
%tNew(idxInf) = tNewApprox(idxInf);

if nargout==2
    dtNew_dp = nan([size(tNew),3]);
    dtNew_dp(:,:,1) = -(exp(smoothness.*tOffset) - exp((smoothness.*t)./scale).*exp(smoothness.*tOffset))./(exp((smoothness.*t)./scale) - exp(smoothness.*tOffset) + exp((smoothness.*t)./scale).*exp(smoothness.*tOffset));
    dtNew_dp(:,:,2) = (exp((smoothness.*t)./scale).*(exp(-smoothness.*tOffset) + 1).*(t - scale.*tOffset + t.*exp(smoothness.*tOffset)))./(scale.*smoothness.*(exp(smoothness.*tOffset) + 1).*(exp((smoothness.*t)./scale).*(exp(-smoothness.*tOffset) + 1) - 1)) - log(exp((smoothness.*t)./scale).*(exp(-smoothness.*tOffset) + 1) - 1)./smoothness.^2;
    dtNew_dp(:,:,3) = -(t.*exp((smoothness.*t)./scale).*(exp(-smoothness.*tOffset) + 1))./(scale.^2.*(exp((smoothness.*t)./scale).*(exp(-smoothness.*tOffset) + 1) - 1));
end

end



