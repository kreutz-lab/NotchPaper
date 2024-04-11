function msbTicksBold(ax)

% msbTicksBold(ax)
%
% Changes the ticklabels to boldface in the axis object ax. Will produce
% unintended results if there are already elements in boldface.
%
% ax: Axis to use on [usually: gca]
%
% Example:
%
% plot(1:10);
% msbTicksBold(gca);
%
% See also: msbAxesThick

if ~exist('ax','var')
    disp(['ERROR: Specify an axis.',...
        ' Execute msbTicksBold(gca) to use the current axis']);
    return;
end

% Save the old tick values, use of this function could overwrite these? (I
% think changing the ticklabels to bold face led to a different number of 
% ticks in some instances) 
xtickz = get(ax,'XTick');
ytickz = get(ax,'YTick');

% Get tick labels and make containers for new ones:
xticklabz = get(ax,'XTickLabel');
xticklabz_new = cell(size(xticklabz));
yticklabz = get(ax,'YTickLabel');
yticklabz_new = cell(size(yticklabz));

% Make tick labels in bold:
for ii = 1:length(xticklabz)
    xticklabz_new{ii} = ['\bf ',xticklabz{ii}];
end
for ii = 1:length(yticklabz)
    yticklabz_new{ii} = ['\bf ',yticklabz{ii}];
end

% Set new tick labels to the axis and reset ticks in the case something
% changed:
set(ax,'XTickLabel',xticklabz_new);
set(ax,'YTickLabel',yticklabz_new);
set(ax,'XTick',xtickz);
set(ax,'YTick',ytickz);

end

