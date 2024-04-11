% Plot the cell counts of the WT conditions over all different experiments.
%
% In different gene perturbation experiments, the WT condition was always 
% generated from the same batch as the perturbation experiments in order to
% have internal controls. Specifically, it is likely that each experiment
% slightly differs in the scale of the data, such that a scale parameter
% for each experiment exists.

tbl_cond = ReadoutConditions(1);

tbl_cond.Experiment = NaN(size(tbl_cond,1),1);
tbl_cond.Experiment(strcmp(tbl_cond.ex1,'1')) = 1;
tbl_cond.Experiment(strcmp(tbl_cond.ex2,'1')) = 2;
tbl_cond.Experiment(strcmp(tbl_cond.ex3,'1')) = 3;
tbl_cond.Experiment(strcmp(tbl_cond.ex4,'1')) = 4;
tbl_cond.Experiment(strcmp(tbl_cond.ex5,'1')) = 5;
tbl_cond.Experiment(strcmp(tbl_cond.ex8,'1')) = 6;
tbl_cond.Experiment(strcmp(tbl_cond.ex9,'1')) = 7;
tbl_cond.Experiment(strcmp(tbl_cond.ex12,'1')) = 8;
tbl_cond.Experiment(strcmp(tbl_cond.ex13,'1')) = 9;
tbl_cond.Experiment(strcmp(tbl_cond.ex14,'1')) = 10;
tbl_cond.Experiment(strcmp(tbl_cond.ex20,'1')) = 11;
tbl_cond.Experiment(strcmp(tbl_cond.ex22,'1')) = 12;
tbl_cond.Experiment(strcmp(tbl_cond.ex23,'1')) = 13;
tbl_cond.Experiment(strcmp(tbl_cond.ex24,'1')) = 14;
tbl_cond.Experiment(strcmp(tbl_cond.ex25,'1')) = 15;
xticklabz = {'1','2','3','4','5','8','9','12','13','14',...
    '20','22','23','24','25'};
ylabz = {'ISC','MCC','SSC'};
eps = 0.1;

figure('Position',[50,50,1000,550])
ind_model_cond = find(strcmp(tbl_cond.data_names,...
    "Controls_Cells_timetrafo_only_new"));
for kk = 1:3
    % Loop over cell types
    subplot(3,1,kk)
    hold on
    for jj = 1:length(ind_model_cond)
        % Loop over experiments
        x = tbl_cond.Experiment(ind_model_cond(jj));
        % Identify where corresponding control condition is
        yExp_pert = ar.model.data(ind_model_cond(jj)).yExp(:,kk);
        ySimu_pert = ar.model.data(ind_model_cond(jj)).yExpSimu(:,kk);
        scatter(x*(ones(size(yExp_pert))),yExp_pert,30,"blue",'filled');
        scatter(x*(ones(size(ySimu_pert))),ySimu_pert,40,...
            'red','filled','s');
        xticks(1:15);
        xticklabels(xticklabz);
        xlim([0.5,16.5]);
        ylim([0,130]);
        xlabel('Experiment')
        ylabel(ylabz{kk});
        grid on
        msbAxesThick(gca)
        msbTicksBold(gca)
    end
    hold off
end
