% Plot the spatial distribution of 2D pheromone gradients and 3D pheromone
% gradients. All concentrations were time-averaged from 50 simulations.

load('FigureData/Figure5C.mat')
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

% Visualize the distance from the pheromone source.
L = 8.8623;
space = 0.3;
draw_filled_circle(L,space)

function draw_filled_circle(L,space)
N = floor(L/4/space); 
centers = repmat([3/4*L,3/4*L],[N,1]);
center = [3/4*L,3/4*L];
radius = [0,space:space:L/4];
figure('units','pixels','position',[0 0 1000,300]);
tiledlayout(1,numel(radius)-1,'tilespacing','compact')
for i = 1:numel(radius)-1
    nexttile; hold on; 
    viscircles(centers,radius(2:end),'color','k','linewidth',3)
    axis equal
    for curr_rad = radius(i):0.05:radius(i+1)
        viscircles(center,curr_rad,'color','k','linewidth',0.2)
    end
    box on
    axis off 
    set(gca, 'color', 'none');
end
end