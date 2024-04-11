%function [t_new] = timeTrafoLofLinear(t_old,t_offset,t_end)
%

function [t_new] = timeTrafoLofLinear(t,t_offset,t_end)

n = -t_offset;
m = 1-(-t_offset./t_end);
t_new = max(m .* t + n, 0);

end



