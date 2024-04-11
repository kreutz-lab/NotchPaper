%function [chi2,dchi2_dp] = chiSquare(vec1,vec2,sigma2,dvec1_dp)
% This function calculates the chi squared, i.e. weighted euclidean
% distance, between two vectors (that represent cell compositions). The 
% weights are the standard deviations for the entries of the second vector.
%
%    vec1      cell composition predicted by the model
%    vec2      measured target cell compoistion
%    sigma2    standard deviation of the measured target cell composition
%    dvec1_dp  derivative of the model prediciton wrt to the parameters

function [chi2,dchi2_dp] = chiSquare(vec1,vec2,sigma2,dvec1_dp)
if size(vec1,1)~=size(vec2,1)
    error('chiSquare: the two input vectors must have the same number of rows')
end
if size(vec2,2)~=1
    error('chiSquare: the second input vector must be a single column vector')
end
if nargout==2
    nPars = 2;
    if size(dvec1_dp,2)~=[size(vec1,2),nPars]
        error('chiSquare: gradient has wrong dimensions')
    end
    if nargin<3
        error('chiSquare: gradient info is missing')
    end
end
if size(sigma2)~=size(vec2)
    error('chiSquare: the second input vector must be a single column vector')
end

% vec1_scale = 100./sum(vec1,1);
% vec2_scale = 100./sum(vec2,1);
% chi2 = sum(0.5.*(vec1_scale.*vec1-vec2_scale.*vec2).^2./(vec2_scale.*sigma2).^2,1);
chi2 = sum(0.5.*(vec1-vec2).^2./sigma2.^2,1);

if nargout==2
    dchi2_dp = sum((vec1-vec2)./sigma2.^2.*dvec1_dp,1);
    dchi2_dp = reshape(dchi2_dp,[size(dchi2_dp,2),size(dchi2_dp,3)]);
end

end

