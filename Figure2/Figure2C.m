% Simulations were performed with 3000 initially pre-polarized Cdc42-GTP, 
% 280 uniformly distributed Far1-GEF and 2500 uniformly distributed receptors.
% The receptor residence time was varied.

% Here we plotted the relationship between K at the final time point (4000
% seconds) and receptor residence time.
load('FigureData/Figure2C.mat')
figure('position',[300 300 550 450]); hold; 
shadedErrorBar(receptor_residence_time,mean(K),std(K),'LineProps',...
    {'Linewidth',3,'color','k','marker','o'},'transparent',true,...
    'patchSaturation',0.1)
xlabel('Receptor residence time (min)')
ylabel('K at 4000 seconds')
set(gca,'fontsize',25)

% Here we showed the snapshots of the distribution of Cdc42-GTP at 4000 seconds
% with increasing receptor residence time.
load('Coordinates/Figure2C_coordinates.mat')
L = 8.8623; % domain length
figure('position',[300,300,800,300])
tiledlayout(1,5,'tilespacing','compact')
nexttile
plot(x_1,y_1,'k.','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;

nexttile
plot(x_2,y_2,'k.','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;

nexttile
plot(x_3,y_3,'k.','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;

nexttile
plot(x_4,y_4,'k.','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;

nexttile
plot(x_5,y_5,'k.','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;