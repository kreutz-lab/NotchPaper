% Make nice plot of all model states in all Hes GoF/LoF conditions

inds_x = [1:12,22:27];
%inds_x = [1:15,25:30];
xnames = ar.model.xNames(inds_x);
conds = [2:7,1];
cond_names = {'WT','hes7_lof','hes5_lof','hes4_lof',...
    'hes7_gof','hes5_gof','hes4_gof'};

logmode = 0;
figure('Position',[100,100,1000,500])
for ii = 1:length(xnames)
    subplot(3,6,ii)
    hold on
    for jj = 1:length(conds)
        xplot = ar.model.condition(conds(jj)).tFine;
        if logmode == 1
            yplot = log10(...
                ar.model.condition(conds(jj)).xFineSimu(:,inds_x(ii)));
        else
            yplot = ar.model.condition(conds(jj)).xFineSimu(:,inds_x(ii));
        end
        plot(xplot,yplot,'LineWidth',2)       
    end
    title(xnames(ii),'Interpreter','none')
    msbAxesThick(gca);
    msbTicksBold(gca);
    hold off
end
legend(cond_names(conds),'Interpreter','none');