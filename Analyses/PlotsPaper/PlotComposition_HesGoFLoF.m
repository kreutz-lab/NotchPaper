% This script generates a comparison plot of measured vs estimated cell
% type compositions for all hes perturbations.

% cd C:\Users\litwin\Documents\MATLAB\NotchPaper
% results = '20240325T171819_HesGoFLoF_mppconversion_cellprod';
% arLoad(results)
% arSimu(true,true);

tbl_conds = ReadoutConditions(1);
data_conds = 9:40;
model_conds = tbl_conds.ModelCondition(data_conds);
cond_names = {'WT','hes7 LoF','hes5 LoF','hes4 LoF',...
    'hes7 GoF','hes5 GoF','hes4 GoF'};
cell_names = {'ISC','MCC','SSC'};

t_data = 1240.3;
ydata_raw = {};
ymodel_raw = {};
sd_plots = {};
for ii = 1:7
    data_conds_tmp = data_conds(model_conds == ii);
    ydatas = [];
    ymodels = NaN(length(data_conds_tmp),3);
    for jj = 1:length(data_conds_tmp)
        tmodels_tmp = ar.model.data(data_conds_tmp(jj)).tFine;
        ymodels_tmp = ar.model.data(data_conds_tmp(jj)).yFineSimu;
        ydatas_tmp = ar.model.data(data_conds_tmp(jj)).yExp;
        ymodels(jj,:) = interp1(tmodels_tmp,ymodels_tmp,t_data/10);
        ydatas = [ydatas;ydatas_tmp];
    end
    ymodel_raw{ii} = mean(ymodels,1);
    ydata_raw{ii} = mean(ydatas,1);
end

ydata_mat = cell2mat(ydata_raw');
ymodel_mat = cell2mat(ymodel_raw');
ydata_plots = 100*ydata_mat./sum(ydata_mat,2);
ymodel_plots = 100*ymodel_mat./sum(ymodel_mat,2);

plot_cond = [1,4,7,3,6,2,5];
x_prev = [];
y_prev = [];
for ii = 1:length(plot_cond)
    x_bar = [x_prev,2.5*(ii-1)+[1,2]];
    y_bar = [y_prev;ydata_plots(plot_cond(ii),:);...
        ymodel_plots(plot_cond(ii),:)];
    x_prev = x_bar;
    y_prev = y_bar;
end

clrs = [207,204,45;46,206,49;252,51,51]/255;
figure('Position',[50,50,800,300]);
bars = bar(x_bar,y_bar','stacked');
for ii = 1:3
    set(bars(ii),'FaceColor',clrs(ii,:))
end
ylim([0,100])
xticks(x_bar);
xticklabels({'D','M','D','M','D','M','D','M','D','M','D','M','D','M'});
ylabel('Relative Cell Composition')
XAxis = get(gca,'XAxis');
set(XAxis,'TickLength',[0,0]);
msbAxesThick(gca)
msbTicksBold(gca)