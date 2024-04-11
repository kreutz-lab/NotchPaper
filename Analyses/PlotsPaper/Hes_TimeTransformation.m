% This script generates plots of the time transformed version of 
% hes RNA components or cell type production rates.
% 
% Needs trafoAna object from timeTrafoAna.m . You can specify in this
% script which model result should be used (1,2 or 2.1)
%
% timeTrafoAna;

% plotmode = 'cell';
    % Plot cell type production rates
plotmode = 'hes';
    % Plot hes RNA
timeTrafo = trafoAna.info.timeTrafo;
ps_trafo = [trafoAna.lof.pSample,trafoAna.gof.pSample];

t_model = ar.model.condition(1).tFine;
t_lof = timeTrafoJoined(t_model,ps_trafo(1,1),ps_trafo(2,1),t_model(end));
t_gof = timeTrafoJoined(t_model,ps_trafo(1,2),ps_trafo(2,2),t_model(end));
if strcmp(plotmode,'hes')
    hes4 = ar.model.condition(1).xFineSimu(:,...
        strcmp(ar.model.x,'hes4_rna'));
    hes5 = ar.model.condition(1).xFineSimu(:,...
        strcmp(ar.model.x,'hes5_rna'));
    hes7 = ar.model.condition(1).xFineSimu(:,...
        strcmp(ar.model.x,'hes7_rna'));
    hes4 = 10.^ar.p(strcmp(ar.pLabel,'scale_hes4'))*hes4;
    hes5 = 10.^ar.p(strcmp(ar.pLabel,'scale_hes5'))*hes5;
    hes7 = 10.^ar.p(strcmp(ar.pLabel,'scale_hes7'))*hes7;
    ys = [hes4,hes5,hes7];
    legs = {'hes4','hes5','hes7'};
    clrs = [27,158,119;117,112,179;231,41,138]/255;
elseif strcmp(plotmode,'cell')
    fluxNames = {'Differentiation into ISC', ...
        'Differentiation into MCC', 'Differentiation into SSC'};
    isc = ar.model.condition(1).vFineSimu(:,...
        strcmp(ar.model.v,fluxNames{1}));
    mcc = ar.model.condition(1).vFineSimu(:,...
        strcmp(ar.model.v,fluxNames{2}));
    ssc = ar.model.condition(1).vFineSimu(:,...
        strcmp(ar.model.v,fluxNames{3}));
    ys = [isc,mcc,ssc];
    legs = {'isc','mcc','ssc'};
    clrs = [207,204,45;46,206,49;252,51,51]/255;
end
ts = [t_model,t_lof,t_gof];
ys_trafo = NaN([size(ys),3]);
for ii = 1:3
    ys_trafo(:,:,ii) = interp1(t_model,ys,ts(:,ii));
end

titlez = {'Wildtype','Notch LoF','Notch GoF'};
figure
for ii = 1:3
    subplot(3,1,ii)
    hold on
    for jj = 1:3
        plot(t_model,ys_trafo(:,jj,ii),'LineWidth',2,'Color',clrs(jj,:))
        if ii == 1
            legend(legs)
        end
    end
    hold off
    xlim([0,1200])
    if ii == 3
        xlabel('Time [min]');
    end
    title(titlez{ii})
    msbAxesThick(gca);
    msbTicksBold(gca);
end
