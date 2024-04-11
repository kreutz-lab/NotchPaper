% This script plots the observed cell counts for model 1, model 2 and 
% model 2.1 into one figure

cd C:\Users\litwin\Documents\MATLAB\NotchPaper
 
results = {'20221215T175813_ple','20240325T112126_withspdef',...
    '20240325T171819_HesGoFLoF_mppconversion_cellprod'};

data_conds = {2,2,9:23};

cell_names = {'ISC','MCC','SSC'};
tmodel_plots = {};
tdata_plot = 1240.3;
ymodel_plots = {};
sd_plots{1} = [2.9,2.2,1.8];
sd_plots{2} = [2.9,2.2,1.8];
for ii = 1:3
    arLoad(results{ii})
    arSimu(true,true);
    if ii == 3
        n_conds = length(data_conds{3});
        t_refs = 0.1:0.1:140;
        ymodels = NaN(length(t_refs),3,n_conds);
        ydatas = [];
        for jj = 1:n_conds
           tmodels_tmp = ar.model.data(data_conds{ii}(jj)).tFine;
           ymodels_tmp = ar.model.data(data_conds{ii}(jj)).yFineSimu;
           ydatas_tmp = ar.model.data(data_conds{ii}(jj)).yExp;
           ymodels(:,:,jj) = interp1(tmodels_tmp,ymodels_tmp,t_refs);
           ydatas = [ydatas;ydatas_tmp];
        end
        tmodel_plots{ii} = 10*t_refs';
        ymodel_plots{ii} = mean(ymodels,3);
        ydata_plots{ii} = mean(ydatas,1);
        sd_plots{ii} =  std(ydatas,1)/sqrt(size(ydatas,1));
    else
        ymodel_plots{ii} = ar.model.data(data_conds{ii}).yFineSimu;
        ydata_plots{ii} = ar.model.data(data_conds{ii}).yExp;
        tmodel_plots{ii} = ar.model.data(data_conds{ii}).tFine;
    end
end

figure('Position',[50,50,500,300]);
for ii = 1:3
    % Loop over models
    for jj = 1:3
        % Loop over cell types
        subplot(3,3,3*(jj-1)+ii)
        hold on
        plot(tmodel_plots{ii},ymodel_plots{ii}(:,jj),'LineWidth',2)
        scatter(tdata_plot,ydata_plots{ii}(jj),15,'k','filled')
        plot([tdata_plot,tdata_plot],...
            [ydata_plots{ii}(jj)-sd_plots{ii}(jj),...
            ydata_plots{ii}(jj)+sd_plots{ii}(jj)],...
            'LineWidth',2,'Color','k')
        hold off
        ylim([0,65])
        xlim([0,1300])
        if jj == 3
            xlabel('\bf Time [min]');
        end
        if ii == 1
            ylabel(['\bf',cell_names{jj},' Counts']);
        end
        if jj == 1
            if ii == 1
                title('Model 1')
            elseif ii == 2
                title('Model 2')
            elseif ii == 3
                title('Model 2.1')
            end
        end
        msbAxesThick(gca);
        msbTicksBold(gca);
    end
end