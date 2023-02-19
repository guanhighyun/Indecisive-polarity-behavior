% Simulations were performed with 3000 initially pre-polarized Cdc42-GTP, 
% 280 uniformly distributed Far1-GEF and 2500 uniformly distributed receptors.
% The receptor residence time was ~ 5.8 min (k = 0.002/s).

% Here we showed the snapshots of the distribution of Cdc42-GTP and active 
% receptors at different time points.

load('Coordinates/Figure2B_coordinates.mat')
L = 8.8623; % domain length
figure('position',[300 300 400 450]);
tiledlayout(2,2,'TileSpacing','compact')

nexttile
plot(x_1,y_1,'b.','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;

nexttile
plot(x_2,y_2,'b.','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;

nexttile
plot(x_3,y_3,'.','color','#A2142F','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('0 min','fontsize',25)

nexttile
plot(x_4,y_4,'.','color','#A2142F','markersize',0.5)
xticks([]); yticks([]); ylim([0,L]); xlim([0,L]); axis square;
xlabel('0.3 min','fontsize',25)

text(-5,22.5,'Cdc42-GTP','fontsize',25)
text(-6,10,'Active receptors','fontsize',25)
