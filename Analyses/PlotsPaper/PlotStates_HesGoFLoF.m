% Plots estimated model states in model units (MU) for all important
% dynamic states appearing in the model. This generates three figures, 
% one for each perturbation of hes (hes4/hes5/hes7). Green corresponds to
% GoF, red to LoF and black to Wildtype.

cd C:\Users\litwin\Documents\MATLAB\NotchPaper
results = '20240325T171819_HesGoFLoF_mppconversion_cellprod';
arLoad(results)
arSimu(true,true);

inds_x = [1:12,22:27];
xnames = ar.model.xNames(inds_x);
xnames_plot = {'Multipotent Progenitors','Early Progenitors',...
    'Basal Cells','ISC','MCC','MCC_late','SSC','Ligand_RNA',...
    'Ligand_Prot','hes4 RNA','hes5 RNA','hes7 RNA','hes4 Prot',...
    'hes5 Prot','hes7 Prot','tp63','spdef RNA','spdef Prot'};
plot_conds = {[1,4,7],[1,3,6],[1,2,5]};
cond_names = {'WT','hes7_lof','hes5_lof','hes4_lof',...
    'hes7_gof','hes5_gof','hes4_gof'};

clrs_lof = [0.8,0.2,0.2];
clrs_gof = [0.2,0.8,0.2];
clrs = [0,0,0;clrs_lof;clrs_lof;clrs_lof;clrs_gof;clrs_gof;clrs_gof];

figs = gobjects(3,1);
for jj = 1:length(plot_conds)
    figs(jj) = figure('Position',[100,100,500,1000]);
    plot_conds_tmp = plot_conds{jj};
    for ii = 1:length(xnames)
        subplot(6,3,ii)
        hold on
        for kk = 1:3
            xplot = 10*ar.model.condition(plot_conds_tmp(kk)).tFine;
            yplot = ar.model.condition(plot_conds_tmp(kk)).xFineSimu(:,inds_x(ii));
            plot(xplot,yplot,'LineWidth',2,...
                'Color',clrs(plot_conds_tmp(kk),:));
        end
        hold off
        title(xnames_plot(ii),'Interpreter','none')
        if mod(ii,3) == 1
            ylabel('MU')
        end
        if ii > 15
            xlabel('Time [min]')
        end
        msbAxesThick(gca);
        msbTicksBold(gca);
    end
end