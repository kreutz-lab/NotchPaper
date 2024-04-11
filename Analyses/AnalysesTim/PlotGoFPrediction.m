% Provides an accurate overwiew plot of measured cell counts in the 
% hes GoF Condition vs. Control over all perturbations and cell types.
% Additionally, these are all split over experiments and corresponding
% model predictions are also shown.
%
% Model states need to be integrated first by calling arSimu

tbl_cond = ReadoutConditions(1);

tbl_cond.Experiment = NaN(size(tbl_cond,1),1);
tbl_cond.Experiment(strcmp(tbl_cond.ex1,'1')) = 1;
tbl_cond.Experiment(strcmp(tbl_cond.ex9,'1')) = 2;
tbl_cond.Experiment(strcmp(tbl_cond.ex12,'1')) = 3;
tbl_cond.Experiment(strcmp(tbl_cond.ex13,'1')) = 4;
tbl_cond.Experiment(strcmp(tbl_cond.ex14,'1')) = 5;
tbl_cond.Experiment(strcmp(tbl_cond.ex20,'1')) = 6;
tbl_cond.Experiment(strcmp(tbl_cond.ex22,'1')) = 7;
tbl_cond.Experiment(strcmp(tbl_cond.ex23,'1')) = 8;
tbl_cond.Experiment(strcmp(tbl_cond.ex24,'1')) = 9;
xticklabz = {'1','9','12','13','14','20','22','23','24'};
lc_cond = [5,6,7];
ylabz = {'ISC','MCC','SSC'};
clrs_pert = [55,126,184;77,175,74;152,78,163]/255;
clr_control = [228,26,28]/255;

figure('Position',[50,50,1200,550])
conds = lc_cond;
eps = -0.2;
clrs = clrs_pert+0.1;
for ii = 1:length(conds)
    % Loop over perturbations
    ind_model_cond = find((tbl_cond.ModelCondition == conds(ii)) & ...
        ~strcmp(tbl_cond.data_names,'cell_prior_timetrafo3'));
    for kk = 1:3
        % Loop over cell types
        subplot(3,3,3*(ii-1)+kk)
        hold on
        for jj = 1:length(ind_model_cond)
            % Loop over experiments
            x = tbl_cond.Experiment(ind_model_cond(jj));
            yExp_pert = ar.model.data(ind_model_cond(jj)).yExp(:,kk);
            ySimu_pert = ar.model.data(ind_model_cond(jj)).yExpSimu(:,kk);
            scatter(x*(ones(size(yExp_pert)))+eps,yExp_pert,30,...
                clrs(ii,:),'filled');
            scatter(x*(ones(size(ySimu_pert)))+eps,ySimu_pert,40,...
                'black','filled','s');
            ind_control = find((tbl_cond.Experiment == x) & ...
                (tbl_cond.ModelCondition == 1));
            % Identify where corresponding control condition is
            yExp_control = ar.model.data(ind_control).yExp(:,kk);
            ySimu_control = ar.model.data(ind_control).yExpSimu(:,kk);
            scatter(x*(ones(size(yExp_control))),yExp_control,30,...
                clr_control,'filled');
            scatter(x*(ones(size(ySimu_control))),ySimu_control,40,...
                'black','filled','s');

            xticks(1:length(xticklabz));
            xticklabels(xticklabz);
            xlim([0.5,length(xticklabz)+0.5]);
            ylim([0,130]);
            xlabel('Experiment')
            ylabel(ylabz{kk});
            grid on
            msbAxesThick(gca)
            msbTicksBold(gca)
        end
        hold off
    end
end
