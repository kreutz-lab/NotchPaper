%function [t_new] = timeTrafoJoinedLinear(t_old,t_offset,t_end)
%

function [t_new] = timeTrafoJoinedLinear(t,t_offset,t_end)

if t_offset<=0 % gof trafo (above identity)
    t_new = timeTrafoGofLinear(t,t_offset,t_end);
else % lof trafo (below identity)
    t_new = timeTrafoLofLinear(t,t_offset,t_end);
end

end



