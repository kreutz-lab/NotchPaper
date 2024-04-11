% Plot production and degradation rates of different RNA components

ts = ar.model.condition.tFine;

d_hes4 = 10^(ar.p(strcmp(ar.pLabel,'deg_hes4_rna_fc'))+...
    ar.p(strcmp(ar.pLabel,'deg_hes_rna')));
d_hes5 = 10^(ar.p(strcmp(ar.pLabel,'deg_hes5_rna_fc'))+...
    ar.p(strcmp(ar.pLabel,'deg_hes_rna')));
d_hes7 = 10^(ar.p(strcmp(ar.pLabel,'deg_hes7_rna_fc'))+...
    ar.p(strcmp(ar.pLabel,'deg_hes_rna')));
d_tp63 = 10^ar.p(strcmp(ar.pLabel,'deg_tp63_rna'));
d_spdef = 10^ar.p(strcmp(ar.pLabel,'deg_spdef_rna'));
d_lig = 10^ar.p(strcmp(ar.pLabel,'deg_ligand_rna'));

hes4s = ar.model.condition(1).xFineSimu(:,...
    strcmp(ar.model.xNames,'hes4_rna'));
hes5s = ar.model.condition(1).xFineSimu(:,...
    strcmp(ar.model.xNames,'hes5_rna'));
hes7s = ar.model.condition(1).xFineSimu(:,...
    strcmp(ar.model.xNames,'hes7_rna'));
tp63s = ar.model.condition(1).xFineSimu(:,...
    strcmp(ar.model.xNames,'tp63_rna'));
spdefs = ar.model.condition(1).xFineSimu(:,...
    strcmp(ar.model.xNames,'spdef_rna'));
ligs = ar.model.condition(1).xFineSimu(:,...
    strcmp(ar.model.xNames,'ligand_rna'));

p_hes4 = ar.model.condition(1).zFineSimu(:,...
    strcmp(ar.model.z,'prod_hes4_rna'));
p_hes5 = ar.model.condition(1).zFineSimu(:,...
    strcmp(ar.model.z,'prod_hes5_rna'));
p_hes7 = ar.model.condition(1).zFineSimu(:,...
    strcmp(ar.model.z,'prod_hes7_rna'));
p_tp63 = ar.model.condition(1).zFineSimu(:,...
    strcmp(ar.model.z,'prod_tp63_rna'));
p_spdef = ar.model.condition(1).zFineSimu(:,...
    strcmp(ar.model.z,'prod_spdef_rna'));
p_lig = ar.model.condition(1).zFineSimu(:,...
    strcmp(ar.model.z,'prod_ligand_rna'));

plotflag = 'abs';
if contains(plotflag,'abs')
    ylab = 'Log10(Absolute Production)';
    plot_p_hes4 = log10(p_hes4);
    plot_p_hes5 = log10(p_hes5);
    plot_p_hes7 = log10(p_hes7);
    plot_p_tp63 = log10(p_tp63);
    plot_p_spdef = log10(p_spdef);
    plot_p_lig = log10(p_lig);
    plot_d_hes4 = log10(d_hes4.*hes4s);
    plot_d_hes5 = log10(d_hes5.*hes5s);
    plot_d_hes7 = log10(d_hes7.*hes7s);
    plot_d_tp63 = log10(d_tp63.*tp63s);
    plot_d_spdef = log10(d_spdef.*spdefs);
    plot_d_lig = log10(d_lig.*ligs);
elseif contains(plotflag,'unlog')
    ylab = 'Absolute Production';
    plot_p_hes4 = p_hes4;
    plot_p_hes5 = p_hes5;
    plot_p_hes7 = p_hes7;
    plot_p_tp63 = p_tp63;
    plot_p_spdef = p_spdef;
    plot_p_lig = p_lig;
    plot_d_hes4 = d_hes4.*hes4s;
    plot_d_hes5 = d_hes5.*hes5s;
    plot_d_hes7 = d_hes7.*hes7s;
    plot_d_tp63 = d_tp63.*tp63s;
    plot_d_spdef = d_spdef.*spdefs;
    plot_d_lig = d_lig.*ligs;
elseif contains(plotflag,'rel')
    ylab = 'Log10(Relative Production)';
    plot_p_hes4 = log10(p_hes4./hes4s);
    plot_p_hes5 = log10(p_hes5./hes5s);
    plot_p_hes7 = log10(p_hes7./hes7s);
    plot_p_tp63 = log10(p_tp63./tp63s);
    plot_p_spdef = log10(p_spdef./spdefs);
    plot_p_lig = log10(p_lig./ligs);
    plot_d_hes4 = log10(d_hes4);
    plot_d_hes5 = log10(d_hes5);
    plot_d_hes7 = log10(d_hes7);
    plot_d_tp63 = log10(d_tp63);
    plot_d_spdef = log10(d_spdef);
    plot_d_lig = log10(d_lig);
end
cmap = lines;
clrs = cmap(1:6,:);
figure('Position',[50,50,400,400]);
hold on
plot(ts,plot_p_hes4,'LineWidth',2,'Color',clrs(1,:))
plot(ts,plot_p_hes5,'LineWidth',2,'Color',clrs(2,:))
plot(ts,plot_p_hes7,'LineWidth',2,'Color',clrs(3,:))
plot(ts,plot_p_tp63,'LineWidth',2,'Color',clrs(4,:))
plot(ts,plot_p_spdef,'LineWidth',2,'Color',clrs(5,:))
plot(ts,plot_p_lig,'LineWidth',2,'Color',clrs(6,:))
plot(ts,plot_d_hes4.*ones(size(ts)),...
    'LineWidth',2,'LineStyle','--','Color',clrs(1,:));
plot(ts,plot_d_hes5.*ones(size(ts)),...
    'LineWidth',2,'LineStyle','--','Color',clrs(2,:));
plot(ts,plot_d_hes7.*ones(size(ts)),...
    'LineWidth',2,'LineStyle','--','Color',clrs(3,:));
plot(ts,plot_d_tp63.*ones(size(ts)),...
    'LineWidth',2,'LineStyle','--','Color',clrs(4,:));
plot(ts,plot_d_spdef.*ones(size(ts)),...
    'LineWidth',2,'LineStyle','--','Color',clrs(5,:));
plot(ts,plot_d_lig.*ones(size(ts)),...
    'LineWidth',2,'LineStyle','--','Color',clrs(6,:));
grid on
xlabel('Time [10min]')
ylabel(ylab)
legend({'hes4','hes5','hes7','tp63','spdef','lig'});
hold off