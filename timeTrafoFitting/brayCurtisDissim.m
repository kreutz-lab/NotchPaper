%function [dissimil,ddissimil_dp] = brayCurtisDissim(vec1,vec2,dvec1_dp)
% This function calculates the Bray Curtis dissimliarity between two vectors
% (that represent cell compositions).
%
%    vec1      cell composition predicted by the model
%    vec2      measured target cell compoistion
%    sigma2    standard deviation of the measured target cell composition
%    dvec1_dp  derivative of the model prediciton wrt to the parameters



function [dissimil,ddissimil_dp] = brayCurtisDissim(vec1,vec2,dvec1_dp)
if size(vec1,1)~=size(vec2,1)
    error('brayCurtisSim: the two input vectors must have the same number of rows')
end
if size(vec2,2)~=1
    error('brayCurtisSim: the second input vector must be a single column vector')
end
if nargout==2
    nPars = 2;
    if size(dvec1_dp,2)~=[size(vec1,2),nPars]
        error('brayCurtisSim: gradient has wrong dimensions')
    end
    if nargin<3
        error('brayCurtisSim: gradient info is missing')
    end
end

%vec1 = 100.*vec1./sum(vec1,1);
%vec2 = 100.*vec2./sum(vec2,1);

aux_vec = min([vec1(:),repmat(vec2,[size(vec1,2),1])],[],2);
C_12 = sum(reshape(aux_vec,size(vec1)),1)';
S_1 = sum(vec1,1)';
S_2 = sum(vec2,1)';

dissimil = 1 - 2.*C_12./(S_1 + S_2);

if nargout==2
    dC_12_dp = sum(double(vec1<vec2).*dvec1_dp,1);
    dC_12_dp = reshape(dC_12_dp,size(dC_12_dp,2),size(dC_12_dp,3));
    dS_1_dp = sum(dvec1_dp,1);
    dS_1_dp = reshape(dS_1_dp,size(dS_1_dp,2),size(dS_1_dp,3));
    ddissimil_dp = ...
        - 2 .* dC_12_dp ./(S_1 + S_2)...
        + 2 .* C_12 .* dS_1_dp./(S_1 + S_2).^2;
end

end

