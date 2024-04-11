% This script plots the modelled cell count time-course for Model 2.1. 
% in WT/LoF/GoF for the different hes perturbations (control in black, LoF
% in red, GoF in green).

cd C:\Users\litwin\Documents\MATLAB\NotchPaper
results = '20240325T171819_HesGoFLoF_mppconversion_cellprod';
arLoad(results)
arSimu(true,true);

tbl_conds = ReadoutConditions(1);
data_conds = 9:40;
model_conds = tbl_conds.ModelCondition(data_conds);
cond_names = {'WT','hes7 LoF','hes5 LoF','hes4 LoF',...
    'hes7 GoF','hes5 GoF','hes4 GoF'};
cell_names = {'ISC','MCC','SSC'};

t_data = 1240.3;
t_refs = 0.1:0.1:140;
ydata_plots = {};
ymodel_plots = {};
sd_plots = {};
for ii = 1:7
    data_conds_tmp = data_conds(model_conds == ii);
    ydatas = [];
    ymodels = NaN(length(t_refs),3,length(data_conds_tmp));
    for jj = 1:length(data_conds_tmp)
        tmodels_tmp = ar.model.data(data_conds_tmp(jj)).tFine;
        ymodels_tmp = ar.model.data(data_conds_tmp(jj)).yFineSimu;
        ydatas_tmp = ar.model.data(data_conds_tmp(jj)).yExp;
        ymodels(:,:,jj) = interp1(tmodels_tmp,ymodels_tmp,t_refs);
        ydatas = [ydatas;ydatas_tmp];
    end
    ymodel_plots{ii} = mean(ymodels,3);
    ydata_plots{ii} = mean(ydatas,1);
    sd_plots{ii} =  std(ydatas,1)/sqrt(size(ydatas,1));
end
tmodel_plots = 10*t_refs;

clrs_lof = [0.8,0.2,0.2];
clrs_gof = [0.2,0.8,0.2];
clrs = [0,0,0;clrs_lof;clrs_lof;clrs_lof;clrs_gof;clrs_gof;clrs_gof];
figure('Position',[50,50,800,500]);
plot_cond = {[4,7],[3,6],[2,5]};
for jj = 1:length(cell_names)
    for ii = 1:length(plot_cond)
        subplot(3,3,3*(jj-1)+ii)
        plot_conds_tmp = plot_cond{ii};
        hold on
        for kk = 1:length(plot_conds_tmp)
            ind_tmp = plot_conds_tmp(kk);
            plot(tmodel_plots,ymodel_plots{ind_tmp}(:,jj),...
                'LineWidth',2,'Color',clrs(ind_tmp,:))
            scatter(t_data,ydata_plots{ind_tmp}(jj),...
                20,clrs(ind_tmp,:),'filled')
            plot([t_data,t_data],...
                [ydata_plots{ind_tmp}(jj)-sd_plots{ind_tmp}(jj),...
                ydata_plots{ind_tmp}(jj)+sd_plots{ind_tmp}(jj)],...
                'LineWidth',2,'Color',clrs(ind_tmp,:))
        end
        plot(tmodel_plots,ymodel_plots{1}(:,jj),...
            'LineWidth',2,'Color',clrs(1,:))
        scatter(t_data,ydata_plots{1}(jj),20,clrs(1,:),'filled')
        hold off
        xlim([0,1300])
        ylim([0,105])
        if jj == 3
            xlabel('\bf Time [min]');
        end
        if ii == 1
            ylabel(['\bf',cell_names{jj},' Counts']);
        end
        if jj == 1
            if ii == 1
                title('hes4 LoF/GoF')
            elseif ii == 2
                title('hes5 LoF/GoF')
            elseif ii == 3
                title('hes7 LoF/GoF')
            end
        end
        msbAxesThick(gca);
        msbTicksBold(gca);
    end
end