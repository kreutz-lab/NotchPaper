% Plots modelled RNA time courses vs observed RNA data for all three models
% and all observed RNA components.

cd C:\Users\litwin\Documents\MATLAB\NotchPaper

results = {'20221215T175813_ple','20240325T112126_withspdef',...
    '20240325T171819_HesGoFLoF_mppconversion_cellprod'};

RNA_names = {};
tmodel_plots = {};
tdata_plot = {};
ymodel_plots = {};
sd_plots = {};
for ii = 1:3
    arLoad(results{ii})
    arSimu(true,true);
    RNA_names{ii} = ar.model.data(1).yNames;
    if ii == 3
        tdata_plots{ii} = 10*ar.model.data(1).tExp;
        tmodel_plots{ii} = 10*ar.model.data(1).tFine;
    else
        tdata_plots{ii} = ar.model.data(1).tExp;
        tmodel_plots{ii} = ar.model.data(1).tFine;
    end
    ymodel_plots{ii} = ar.model.data(1).yFineSimu;
    ydata_plots{ii} = ar.model.data(1).yExp;
    sd_plots{ii} = ar.model.data(1).ystdFineSimu;
end

obs_names = {'ubp1','foxi1','mcidas','foxa1',...
    'ligands_tot','tp63','spdef','hes4','hes5','hes7'};

% Fix ylims in advance such that they are consistent across models
ylims_max = cell(10,1);
ylims_min = cell(10,1);
for jj = 1:length(obs_names)
    ylim_max{1} = [];
    ylim_min{1} = [];
    for ii = 1:3
        found_ind = find(strcmp(RNA_names{ii},obs_names{jj}));
        if ~isempty(found_ind)
            ylims_min{jj} = min([ylims_min{jj},...
                min(ydata_plots{ii}(:,found_ind))]);
            ylims_max{jj} = max([ylims_max{jj},...
                max(ydata_plots{ii}(:,found_ind))]);
        end       
    end
end
ylims_min = cell2mat(ylims_min);
ylims_max = cell2mat(ylims_max);
ylims_diff = ylims_max-ylims_min;
ylims_min = ylims_min - 0.1*ylims_diff;
ylims_max = ylims_max + 0.1*ylims_diff;
ytickz_all = [0.01,0.03,0.1,0.3,1,3,10,30,100,300,1000,3000];

figs = gobjects(3,1);
inds = {[1:4],[5:7],[8:10]};
for ii = 1:length(inds)
    % Plot observables in batches:
    obs_names_tmp = obs_names(inds{ii});
    figs(ii) = figure('Position',...
        [50,50,250*length(inds),150*length(obs_names_tmp)]);
    for jj = 1:3
        % Loop over models
        for kk = 1:length(obs_names_tmp)
            % Loop over observables
            ind_obs = find(strcmp(obs_names_tmp{kk},RNA_names{jj}));
                % Find where observable is in model
            if ~isempty(ind_obs)
                subplot(length(obs_names_tmp),3,3*(kk-1)+jj)
                ts = tmodel_plots{jj};
                sd_low = (ymodel_plots{jj}(:,ind_obs) - ...
                    sd_plots{jj}(:,ind_obs));
                sd_high = (ymodel_plots{jj}(:,ind_obs) + ...
                    sd_plots{jj}(:,ind_obs));
                hold on
                patch([ts;ts(end:-1:1)],[sd_low;sd_high(end:-1:1)],...
                    [0,0,0.5],'FaceAlpha',0.1,'EdgeAlpha',0);
                plot(ts,ymodel_plots{jj}(:,ind_obs),...
                    'LineWidth',2)
                scatter(tdata_plots{jj},ydata_plots{jj}(:,ind_obs),...
                    20,'k','filled')
                hold off
                title(obs_names_tmp{kk},'Interpreter','none')
                ylabel('[tpm]')
                if kk == length(obs_names_tmp)
                   xlabel('Time [min]');
                else
                   xticks([]);
                end
                xlim([0,1300]);
                ind_obs_ylim = find(strcmp(obs_names_tmp{kk},obs_names));
                ylim_tmp = [ylims_min(ind_obs_ylim),ylims_max(ind_obs_ylim)];
                ylim(ylim_tmp);
                q_yticks = ((ylim_tmp(1) < 10.^ytickz_all) & ...
                    (ylim_tmp(1) < 10.^ytickz_all));
                yticks(log10(ytickz_all(q_yticks)));
                yticklabels(strsplit(num2str(ytickz_all(q_yticks))));
                msbAxesThick(gca);
                msbTicksBold(gca);
            end
        end
    end
end

