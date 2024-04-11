%function [tNew] = timeTrafoJoinedFreeEnd(t,tOffset,smoothness,slope)
%

function [tNew,dtNew_dp] = timeTrafoJoinedFreeEnd(t,tOffset,smoothness,slope)
if(size(smoothness)~=size(tOffset))
    error('timeTrafoJoined: the two parameter array must have same size')
end

idxGof = smoothness<0;
idxIdent = smoothness==0;
idxLof = smoothness>0;

tNew = nan(numel(t),numel(smoothness));

if nargout==2
    dtNew_dp = nan(size(t,1),numel(smoothness),3);
end

if any(idxGof) % gof trafo (above identity)
    if nargout==2
        [tNew, dtNewTmp_dp] = timeTrafoLogistic(t,tOffset(idxGof),-smoothness(idxGof),slope(idxGof));
        dtNewTmp_dp(:,:,2) = -dtNewTmp_dp(:,:,2);
        dtNew_dp(:,idxGof,:) = dtNewTmp_dp;
    else
        tNewTmp = timeTrafoLogistic(t,tOffset(idxGof),-smoothness(idxGof),slope(idxGof));
    end
    tNew(:,idxGof) = tNewTmp;
end

if any(idxIdent) % identity, no trafo
    tNewTmp = repmat(t,[1,sum(idxIdent)]);
    if nargout==2
        dtNew_dp(:,idxIdent,:) = zeros(numel(t),sum(idxIdent),3);
    end
    tNew(:,idxIdent) = tNewTmp;
end

if any(idxLof)% lof trafo (below identity)
    if nargout==2
        [tNewTmp, dtNewTmp_dp] = timeTrafoLogisticInv(t,tOffset(idxLof),smoothness(idxLof),slope(idxLof));
        dtNew_dp(:,idxLof,:) = dtNewTmp_dp;
    else
        tNewTmp = timeTrafoLogisticInv(t,tOffset(idxLof),smoothness(idxLof),slope(idxLof));
    end
    tNew(:,idxLof) = tNewTmp;
end

end



