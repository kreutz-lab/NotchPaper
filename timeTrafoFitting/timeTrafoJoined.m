%function [tNew] = timeTrafoJoined(t,tOffset,smoothness,tEnd)
%

function [tNew,dtNew_dp] = timeTrafoJoined(t,tOffset,smoothness,tEnd)
if(size(smoothness)~=size(tOffset))
    error('timeTrafoJoined: the two parameter array must have same size')
end

idxGof = smoothness<0;
idxIdent = smoothness==0;
idxLof = smoothness>0;

tNew = nan(numel(t),numel(smoothness));

if nargout==2
    dtNew_dp = nan(size(t,1),numel(smoothness),2);
end

if any(idxGof) % gof trafo (above identity)
    if nargout==2
        [tNewTmp, dtNewTmp_dp] = timeTrafoGof(t,tOffset(idxGof),-smoothness(idxGof),tEnd);
        dtNewTmp_dp(:,:,2) = -dtNewTmp_dp(:,:,2);
        dtNew_dp(:,idxGof,:) = dtNewTmp_dp;
    else
        tNewTmp = timeTrafoGof(t,tOffset(idxGof),-smoothness(idxGof),tEnd);
    end
    tNew(:,idxGof) = tNewTmp;
end

if any(idxIdent) % identity, no trafo
    tNewTmp = repmat(t,[1,sum(idxIdent)]);
    if nargout==2
        dtNew_dp(:,idxIdent,:) = zeros(size(t,1),sum(idxIdent),2);
    end
    tNew(:,idxIdent) = tNewTmp;
end

if any(idxLof)% lof trafo (below identity)
    if nargout==2
        [tNewTmp, dtNewTmp_dp] = timeTrafoLof(t,tOffset(idxLof),smoothness(idxLof),tEnd);
        dtNew_dp(:,idxLof,:) = dtNewTmp_dp;
    else
        tNewTmp = timeTrafoLof(t,tOffset(idxLof),smoothness(idxLof),tEnd);
    end
    tNew(:,idxLof) = tNewTmp;
end

end



