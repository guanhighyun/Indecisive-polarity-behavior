% Plot the spatial distribution of 2D pheromone gradients and 3D pheromone
% gradients. All concentrations are time-averaged from 50 simulations.

load('FigureData/Figure5B.mat')
figure('position',[300 300 400 450]); axis square; hold on
p1 = bar(distance,nanmean(concentration_3D),...
    'facecolor','#4DBEEE','linewidth',4,'facealpha',0.4,'edgecolor','#0072BD');
errorbar(distance,nanmean(concentration_3D),nanstd(concentration_3D),...
    '.','linewidth',4,'color','#0072BD')
p2 = bar(distance,nanmean(concentration_2D),...
    'facecolor','#D95319','linewidth',4,'facealpha',0.4,'edgecolor','#A2142F');
errorbar(distance,nanmean(concentration_2D),nanstd(concentration_2D),...
    '.','linewidth',4,'color','#A2142F')
legend([p1 p2], '3D', '2D')
set(gcf,'Position',[300 300 600 500]); 
set(gca,'fontsize',25)
xlabel('Distance from the pheromone source (\mum)')
ylabel('Pheromone concentration (nM)')
hold off