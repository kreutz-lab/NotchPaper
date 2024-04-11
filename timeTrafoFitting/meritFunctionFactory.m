%function [FUN] = meritFunctionFactory(cpr, targetDist, meritType, sigma, trafo)
% This function returns an objective function that compares a target cell
% composition with a predicted one for gain or loss of function condition.
% The returned function maps parameters on objective function value. The
% model prediction is based on wild type production rates and a time 
% transformation. Different distance measures can be chosen, weighted
% euclidean distance or Bray-Curtis-Dissimiliraty.
%
%  cpr           struct containing cell production rates for the wild type
%  targetDist    target cell composition to which the model , see function getTargetDist
%  meritType     distance measure used for comparison of cell compositions:
%                'chi2' or 'bc'. For 'chi2' standard deviation has to be
%                given as argument: see next argument sigma
%  sigma         standard deviation for measured target cell compostion
%  trafo         char specifying which parametrization of the time trafo
%                should be used
%
%
%  FUN    objective function that maps parameter values on objetive
%         function values. can be used for fitting parameters via fmincon
%


function [FUN] = meritFunctionFactory(cpr, targetDist, meritType, sigma, trafo)
if(~exist('meritType','var') | isempty(meritType))
    meritType = 'bc';
end
if(~exist('sigma','var') | isempty(sigma))
    if(strcmp(meritType,'chi2'))
        error('meritFunctionFactory: sigma must be specified for chiSquare objective')
    else
        sigma = nan(size(targetDist));
    end
end
if size(targetDist)~=size(sigma)
    error('meritFunctionFactory: sigma must have same size as targetDist')
end
if(~exist('trafo','var') | isempty(trafo))
    trafo = [];
end
    function [merit, dmerit_dp] = meritFunction(ps, cpr, targetDist, meritType, sigma, trafo)
        %% cell composition
        if nargout==2
            [cellDist, dcellDist_dp] = calcCellDist(ps, cpr, trafo);
        else
            [cellDist] = calcCellDist(ps, cpr, trafo);
        end
        
        %% BC dissimilarity
        if nargout==2
            if strcmp(meritType,'bc')
                [merit, dmerit_dp] = brayCurtisDissim(cellDist, targetDist, dcellDist_dp);
            elseif strcmp(meritType,'chi2')
                [merit, dmerit_dp] = chiSquare(cellDist, targetDist, sigma, dcellDist_dp);
            end
        else
            if strcmp(meritType,'bc')
                [merit] = brayCurtisDissim(cellDist, targetDist);
            elseif strcmp(meritType,'chi2')
                [merit] = chiSquare(cellDist, targetDist, sigma);
            end
        end
    end
FUN = @(ps) meritFunction(ps, cpr, targetDist, meritType, sigma, trafo);
end


