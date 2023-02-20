% Plot time till stabilization
% with pheromone gradients of different steepness.

load('FigureData/Figure5E.mat')
% Data cleaning for generating the box chart and the swarm chart.
index = repelem(pheromone_concentration,1,numel(random_seeds));
index = categorical(index);
data = reshape(first_pol_time,1,numel(first_pol_time));
% Generate the figure.
figure('position',[300 300 500 600])
swarmchart(index,data/60,100,'b','filled'); hold on;
boxchart(index,data/60,'boxfacecolor','b','BoxFaceColorMode','manual',...
'markercolor','none','linewidth',3.5);
set(gca,'fontsize',25)
xlabel({'Pheromone concentration','at the center of the source (nM)'})
ylabel('Time till stabilization (min)')
ylim([0, Inf])