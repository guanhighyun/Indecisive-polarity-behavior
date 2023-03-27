% Simulations were performed with 3000 initially pre-polarized Cdc42-GTP, 
% 280 uniformly distributed Far1-GEF and 2500 uniformly distributed receptors.
% The receptor residence time was varied.

% Here we plotted the relationship between K at the final time point (4000
% seconds) and receptor residence time.
load('FigureData/Figure2C.mat')
figure('position',[300 300 500 500]); hold on
shadedErrorBar(receptor_residence_time,mean(K),std(K),'LineProps',...
    {'Linewidth',3,'color','k','marker','o'},'transparent',true,...
    'patchSaturation',0.1)
xlabel('Receptor residence time (min)')
ylabel('K at the final time point')
set(gca,'fontsize',25)
set(gca,'linewidth',3)
ylim([0,5])
xlim([0,4.5])

% Here we showed the snapshots of the distribution of Cdc42-GTP at 4000 seconds
% with increasing receptor residence time.
load('Coordinates/Figure2C_coordinates.mat')
L = 8.8623; % domain length

% residence time = 0.3472 min (k = 0.048/s)
axes('Position',[0.15 0.75 .15 .15])
scatter(x_1,y_1,3,'k','markerfacecolor','k','markeredgecolor','none')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square; box on;

% residence time = 1.0417 min (k = 0.016/s)
axes('Position',[0.35 0.63 .15 .15])
scatter(x_2,y_2,3,'k','markerfacecolor','k','markeredgecolor','none')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square; box on;

% residence time = 1.3889 min (k = 0.012/s)
axes('Position',[0.4 0.44 .15 .15])
scatter(x_3,y_3,3,'k','markerfacecolor','k','markeredgecolor','none')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square; box on;

% residence time = 2.0833 min (k = 0.008/s)
axes('Position',[0.5 0.25 .15 .15])
scatter(x_4,y_4,3,'k','markerfacecolor','k','markeredgecolor','none')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square; box on;

% residence time = 4.1667 min (k = 0.004/s)
axes('Position',[0.72 0.2 .15 .15])
scatter(x_5,y_5,3,'k','markerfacecolor','k','markeredgecolor','none')
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square; box on;
