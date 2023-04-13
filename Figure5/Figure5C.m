% Plot the spatial distribution of 2D pheromone gradients and 3D pheromone
% gradients. All concentrations were time-averaged from 50 simulations.

load('FigureData/Figure5C.mat')
figure('position',[300 300 600 700]); subplot(3,3,1:6);
data = mean(concentration_3D);
data_error = std(concentration_3D);
bar(distance,data,'facecolor',[0,0.813,1],'edgecolor','k','linewidth',4); hold on
errorbar(distance, data, data_error, 'k.','linewidth',4)

set(gca,'fontsize',25)
ylabel('Pheromone concentration (nM)')
xticks(distance)
xticklabels({'0','0.3','0.6','0.9','1.2','1.5','1.8','2.1'})
set(gca,'linewidth',3)
text(-0.4,-3,'Distance from the pheromone source (\mum)','fontsize',25)
box off

% Visualize the distance from the pheromone source.
L = 8.8623;
space = 0.3;
draw_filled_circle(L,space)

function draw_filled_circle(L,space)
N = floor(L/4/space); 
centers = repmat([3/4*L,3/4*L],[N,1]);
center = [3/4*L,3/4*L];
radius = [0,space:space:L/4];
for i = 1:numel(radius)-1
    axes('Position',[i*0.092+0.11 0.25 .08 .08]); hold on;
    viscircles(centers,radius(2:end),'color','k','linewidth',1)
    curr_rad = (radius(i)+radius(i+1))/2;
    viscircles(center,curr_rad,'color','k','linewidth',5)
    axis square; set(gca,'YTickLabel',[]); set(gca,'XTickLabel',[]);
    box on; axis equal
    axis off 
    set(gca, 'color', 'none');
end
end
