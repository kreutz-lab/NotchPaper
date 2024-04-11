%function [t_new] = timeTrafoGofLinear(t_old,t_offset,t_end)
%

function [t_new] = timeTrafoGofLinear(t,t_offset,t_end)

n = 1./(1./t_end-1./t_offset);
m = -n./t_offset;
t_new = max(m .* t + n, 0);

end



