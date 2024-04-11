function msbAxesThick(ax,width)

% msbAxesThick(ax,width)
%
% This function takes an axis object and plots the axes wit thick lines.
% Call this for a quick and easy upgrade of your generic plot.
%
% ax: Axis to use on [usually: gca]
% width: Width of the plotted axes [default: 1.5]
%
% Example:
%
% plot(1:10);
% msbAxesThick(gca);
%
% See also: msbTicksBold

if ~exist('ax','var')
    disp(['ERROR: Specify an axis.',...
        ' Execute msbAxesThick(gca) to use the current axis']);
    return;
end
if ~exist('width','var')
    width = 1.5;
end

xaxis = get(ax,'XAxis');
set(xaxis,'LineWidth',width);
yaxis = get(ax,'YAxis');
set(yaxis,'LineWidth',width);

end

